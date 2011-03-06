#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'App-WargamersPledge';
all_from 'lib/App/WargamersPledge.pm';

requires 'Catalyst::Runtime' => '5.80030';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; 
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::View::TT';
requires 'Devel::Declare';
requires 'ExtUtils::Depends';
requires 'TryCatch';
requires 'MooseX::Declare';
requires 'MooseX::NonMoose';
requires 'Crypt::Eksblowfish::Bcrypt';
requires 'DBIx::Class::Schema';
requires 'DBIx::Class::EncodedColumn';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Authentication::Credential::Twitter';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
