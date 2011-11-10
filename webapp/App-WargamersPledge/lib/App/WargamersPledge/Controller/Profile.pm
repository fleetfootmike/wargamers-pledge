package App::WargamersPledge::Controller::Profile;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

App::WargamersPledge::Controller::Profile - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched App::WargamersPledge::Controller::Profile in Profile.');
}

sub user :Path :Args(1) {
    my ( $self, $c, $user_id ) = @_;
    my $user = $c->model('API')->get_profile($user_id);
    $c->detach('Root', 'not_found') unless $user;
    
    # User profile
    
    use Data::Dump qw/dump/;
    
    warn dump $user;
    
    # Statistics
    
    my $all_time = $c->model('API')->get_stats($user_id);
    $all_time->{label} = "All Time";
    my $stats = [$all_time];
    
    # Recent purchases
    
    
    
    $c->stash(
              user => $user_id,
              stats => $stats
              );
    
    # TODO
    # Purchases - Paints since start of year
    # Purchases - Paints since now - 12 months
    # Most recent purchases
    # Most recent paints
    # Most recent photos
    # User profile box
    
    #use Data::Dump qw/dump/;
    #$c->response->body("Showing $user_id <pre>" . dump $stats);
}

=head1 AUTHOR

David Dorward,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
