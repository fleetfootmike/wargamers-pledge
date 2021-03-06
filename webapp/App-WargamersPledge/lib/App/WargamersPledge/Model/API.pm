use MooseX::Declare;

class App::WargamersPledge::Model::API extends Catalyst::Model::DBIC::Schema {
    use App::WargamersPledge::Model::API::Types ':all';
    
    __PACKAGE__->config(
        schema_class => 'App::WargamersPledge::Schema',

        connect_info => {
            dsn => 'dbi:mysql:wgpledge',
            user => 'wgpledge',
            password => 'wgpledge',
        }
    );

    method find_or_add_package( Str $manufacturer, Str $description ) {
        my $p = $self->resultset('Package')->find_or_create( {
                                                              manufacturer => $manufacturer, 
                                                              description => $description });
        return $p->id;
    }
    
    method add_manufacturer( Str $name ) {
        $self->resultset('Manufacturer')->create(id => $name);
        return $name;
    }
    
    method add_to_package( Int $package, Str :$description, Int :$count, Str :$manufacturer?, Str :$scale? ) {
        my $p = $self->resultset('Package')->find($package);
        return $p->add_to_figures( 
            {
                description => $description,
                manufacturer => $manufacturer,
                scale => $scale,
            },
            { 
                count => $count
            },
        );
    }
    
    method add_package_to_stash( Str $user, Int $package, Str :$notes?, DateTime :$when? ) {
        my @figures = $self->resultset('Package')->find($package)->figures;
        $when //= DateTime->now();
        foreach my $figure (@figures) {
            my $link = $figure->package_figures( { package => $package });
            
            $self->_purchase_figure( $user, $figure->id, $link->count, $notes, $when );
        }
    }
    
    method _purchase_figure( Str $user, Int $figure, Int $number, Str $notes, DateTime $when ) {
        my $u = $self->resultset("User")->find($user);
        
        my $args = { purchased => $when, number => $number, figure => $figure };
        $args->{notes} = $notes if defined $notes; 
        $u->add_to_purchases( $args );       
    }
        
    method add_to_stash( Str $user, Str :$description, Int :$number, Str :$manufacturer?, Str :$scale?, Str :$notes?, DateTime :$when? ) {
        $when //= DateTime->now();
        my $u = $self->resultset("User")->find($user);
        
        my $args = { description => $description  };
        $args->{manufacturer} = $manufacturer if defined $manufacturer;
        $args->{scale} = $scale if defined $scale;
        
        my $f = $self->resultset('figure')->create($args);
        $self->_purchase_figure( $user, $f->id, $number, $notes, $when );       
        return $f->id;
    }   

    method get_figure_stash (Str $user, HashRef :$search?) {
        my $rs = $self->resultset("User");
        
        my @stash = $rs->search( { id => $user} )->purchases($search);
        return map { $_->id => { $_->get_columns} } @stash;
    }

    method do_action ( Int $purchase, Int :$number, Str :$state?, DateTime :$when?, Str :$notes?, Str :$as? ) {
        $when //= DateTime->now();
        $state //= 'painted';
        
        my $purchase_rs = $self->resultset("Purchase")->find( $purchase );
        
        my $args = { state => $state, num => $number, done => $when };
        $args->{notes} = $notes if defined $notes;
        $args->{use_as} = $as if defined $as;
        
        $purchase_rs->add_to_actions($args);
    }


    method get_actions (Str $user, HashRef $search?) {
        my @actions = $self->resultset("User")->find($user)->actions($search);
        return map { $_->id => { $_->get_columns } } @actions;
    }

    method get_stats (Str $user) {
        my $rs = $self->resultset("User");
        
        my $bought = $rs->purchases()->get_column('num')->sum();
        
        # the simpleminded version
        my $painted = $rs->actions({ action => 'painted'})->get_column('num')->sum();
        
        return { bought => $bought, painted => $painted };
    }

    method get_profile (Str $user) { }
}



=head1 NAME

App::WargamersPledge::Model::API - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<App::WargamersPledge>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<App::WargamersPledge::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.48

=head1 AUTHOR

Mike Whitaker

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
