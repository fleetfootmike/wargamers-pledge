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

sub person :Path :Args(1) {
    my ( $self, $c, $user ) = @_;
    
    my $profile = $c->model('API')->get_profile($user);
    
    $c->detach('unknown_profile') unless defined $profile;
    
    $c->response->body('Found a profile for the specified user');
    
}

sub unknown_profile :Private {
    my ( $self, $c) = @_;
    $c->response->status(404);
}

=head1 AUTHOR

David Dorward,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
