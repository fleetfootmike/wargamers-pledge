package App::WargamersPledge::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

App::WargamersPledge::Controller::Root - Root Controller for App::WargamersPledge

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    # Move this somewhere we can run it for everything

    # Path to redirect back to if we have a form that takes us off page
    $c->stash( here => $c->req->uri );

    # Get details of logged in user
    if ( $c->user ) {
        my $current_user = { user => $c->user->username };
        $c->stash( current_user => $current_user );
    }
}

sub login : Path('login') : Args(0) {
    my ( $self, $c ) = @_;
    my $auth;

    my $_POST = $c->request->body_parameters;

    if ( $_POST->{action} && $_POST->{action} eq 'logout' ) {
        $c->logout;
    }
    else {
        $auth = $c->user();

        if ( $_POST->{username} ) {
            $auth = $c->authenticate(
                {
                    user     => $_POST->{username},
                    password => $_POST->{password}
                }
            );
        }
        elsif ( $_POST->{twitter} ) {
            my $realm = $c->get_auth_realm('twitter');
            $c->res->redirect(
                $realm->credential->authenticate_twitter_url($c) );
        }
    }

    # Unless there was an attempt to login which FAILED
    unless ( ( defined $_POST->{username} || defined $_POST->{password} )
        && !$auth )
    {

        # Redirect to whereever we came from, or the homepage
        my $return_to = $_POST->{return_to} || '/';

        # Check for infinite loops.
        # TODO: We won't generate things like //login but we should add URI
        #       normalisation to this.
        $return_to = "/" if ( $return_to =~ m!^/login! );

        $return_to = '/'
          unless ( URI->new($return_to)->host eq $c->req->uri->host );
        $c->res->redirect($return_to);

    }
    else {

        # We show the login form
    }
}

sub twitter_callback : Path('login/twitter') : Args(0) {
    my ( $self, $c ) = @_;

    # IF twitter says 'no'
    #   THEN offer to try again
    # IF user exists
    #   THEN log in
    # ELSIF form being submitted
    #   THEN check form OK and create user or rerender with errors
    # ELSE render form

    if ( $c->request->parameters->{denied} ) {
        warn "Hello!!!";
        $c->stash->{template} = 'login.tt';
        $c->stash->{data} = { failed => 'denied', default => 'twitter' };
    } elsif ( my $user = $c->authenticate( undef, 'twitter' ) ) {
        # user has an account - redirect or do something cool
        $c->res->redirect("/");
    }
    elsif ( defined $c->request->body_parameters->{username} ) {
        warn "Trying to create a user";
        my ($twitter_user_id) =
          ( $c->user_session->{access_token} =~ m{^(\d+)-} );
        die "Unable to extract twitter user id" unless defined $twitter_user_id;

        my $username = $c->request->body_parameters->{username};

        # TODO: Figure out what rules we actually want to user
        # They should almost certainly allow everything that twitter allows
        # and possibly some more depending on other services
        if ( $username !~ m[^[a-zA-Z0-9][-a-zA-Z0-9]+[a-zA-Z0-9]$] ) {

            # GOTO FORM WITH ERRORS
        }
        elsif ( $c->model('API')->resultset('User')->find($username) ) {

            # GOTO FORM WITH "Already Exists"
        }
        else {
            my $user =
              $c->model('API')->resultset('User')
              ->create( { id => $username } );

            my $twitter_user => $user->create_related(
                'auth_twitter',
                {
                    twitter_user_id      => $twitter_user_id,
                    twitter_access_token => $c->user_session->{access_token},
                    twitter_access_token_secret =>
                      $c->user_session->{access_token_secret}
                }
            );
            my $auth = $c->authenticate( undef, 'twitter' );
            $c->res->redirect("/"); # TODO: Redirect to a welcome, now get started page
        }
    }
    else {

        my ($twitter_user_id) =
          ( $c->user_session->{access_token} =~ m{^(\d+)-} );
        die "Unable to extract twitter user id" unless defined $twitter_user_id;

        # Move this into a model
        use Net::Twitter;
        my $config = $c->config->{authentication}{realms}{twitter};

        my $nt = Net::Twitter->new(
            traits              => [qw/OAuth API::REST/],
            consumer_key        => $config->{consumer_key},
            consumer_secret     => $config->{consumer_secret},
            access_token        => $c->user_session->{access_token},
            access_token_secret => $c->user_session->{access_token_secret},
        );

        my $t_user       = $nt->show_user($twitter_user_id);
        my $twitter_name = $t_user->{name};

        my $user = $c->model('API')->resultset('User')->find($twitter_name);

        $c->stash(
            form_data => {
                t_name        => $twitter_name,
                existing_user => $user
            }
        );
    }

}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
}

=head1 AUTHOR

David Dorward,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
