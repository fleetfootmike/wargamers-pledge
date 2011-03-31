#!/usr/bin/env perl

use feature qw/say/;

my $schemadir = "lib/App/WargamersPledge/Schema/Result";

die "In wrong directory" unless -f "Makefile.PL" && -d $schemadir;

say "Updating schema.";
say "...temporarily removing AuthPassword.pm...";
unlink "$schemadir/AuthPassword.pm";

say "...running create.pl...";
system("script/app_wargamerspledge_create.pl --force  model API DBIC::Schema App::WargamersPledge::Schema create=static dbi:mysql:wgpledge wgpledge wgpledge");

say "...patching AuthPassword.pm...";
system("patch -b $schemadir/AuthPassword.pm < AuthPassword.patch");

say "...done";