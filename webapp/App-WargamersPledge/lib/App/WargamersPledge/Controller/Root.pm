package App::WargamersPledge::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

App::WargamersPledge::Controller::Root - Root Controller for App::WargamersPledge

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    # Move this somewhere we can run it for everything
    
    # Path to redirect back to if we have a form that takes us off page
    $c->stash(request => $c->req->uri->path . '?' . $c->req->uri->query);
    
    # Get details of logged in user
    if ($c->user) {
        my $current_user = {
            user => $c->user->username
        };
        $c->stash(current_user => $current_user);
    }
}

sub login :Path('login') {
    my ( $self, $c ) = @_;
    my $auth;
    
    my $_POST = $c->request->body_parameters;
    
    if ($_POST->{action} && $_POST->{action} eq 'logout') {
        $c->logout;
    } else {
        $auth = $c->user();
        
        if ($_POST->{username}) {
            $auth = $c->authenticate({
                              user => $_POST->{username},
                              password => $_POST->{password}
                              });
        }
    }
    
    # Unless there was an attempt to login which FAILED
    unless ((defined $_POST->{username} || defined $_POST->{password}) && !$auth) {
    
        # Redirect to whereever we came from, or the homepage
        my $return_to = $_POST->{return_to} || '/';
    
        # Check for infinite loops.
        # TODO: We won't generate things like //login but we should add URI
        #       normalisation to this.
        $return_to = "/" if ($return_to =~ m!^/login!);
        
        # TOOD: Is this secure enough? We must not let spammers redirect through us.
        my $redir = $c->req->uri->scheme . '://' . $c->req->uri->host . ':' . $c->req->uri->port . $return_to;
        $c->res->redirect( $redir );
        
    } else {
        # We show the login form
    }    
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

David Dorward,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
