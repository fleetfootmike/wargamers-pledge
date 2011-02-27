#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

use App::WargamersPledge::Schema;

my $schema =
  App::WargamersPledge::Schema->connect( 'dbi:mysql:wgpledge', 'wgpledge', 'wgpledge' );

my $user = $schema->resultset('User')->create(
    {
        id    => 'dorward',
        email => 'david@dorward.me.uk',
    }
);

my $auth_password =
  $user->create_related( 'auth_password', { password => 'testTest' } );
