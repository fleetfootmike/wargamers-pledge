package App::WargamersPledge::Schema::Result::AuthTwitter;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

#__PACKAGE__->load_components("EncodedColumn", "InflateColumn::DateTime");

=head1 NAME

App::WargamersPledge::Schema::Result::AuthTwitter

=cut

__PACKAGE__->table("auth_twitter");


__PACKAGE__->add_columns(
    "user" => {
        data_type      => "varchar",
        default_value  => "",
        is_foreign_key => 1,
        is_nullable    => 0,
        size           => 255,
    },
    twitter_user => {
        data_type   => "varchar",
        is_nullable => 0,
        size        => 255,
    },
    twitter_user_id => {
        data_type   => "varchar",
        is_nullable => 0,
        size        => 255,
    },
    twitter_access_token => {
        data_type   => "varchar",
        is_nullable => 0,
        size        => 255,
    },
    twitter_access_token_secret => {
        data_type   => "varchar",
        is_nullable => 0,
        size        => 255,
    },
);
__PACKAGE__->set_primary_key("user");


=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<App::WargamersPledge::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "App::WargamersPledge::Schema::Result::User",
  { id => "user" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-02-18 06:36:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EgAWs1wzxPG/X+MGWX6l0g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
