package App::WargamersPledge::Schema::Result::AuthTwitter;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

App::WargamersPledge::Schema::Result::AuthTwitter

=cut

__PACKAGE__->table("auth_twitter");

=head1 ACCESSORS

=head2 user

  data_type: 'varchar'
  default_value: (empty string)
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 twitter_user

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 twitter_user_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 twitter_access_token

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 twitter_access_token_secret

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "user",
  {
    data_type => "varchar",
    default_value => "",
    is_foreign_key => 1,
    is_nullable => 0,
    size => 255,
  },
  "twitter_user",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "twitter_user_id",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "twitter_access_token",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "twitter_access_token_secret",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("user");
__PACKAGE__->add_unique_constraint("twitter_user_id", ["twitter_user_id"]);

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


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-03-30 11:50:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FTOt59PB/RIG7S+EZe0Fdw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->load_components('EncodedColumn');
__PACKAGE__->meta->make_immutable;
1;