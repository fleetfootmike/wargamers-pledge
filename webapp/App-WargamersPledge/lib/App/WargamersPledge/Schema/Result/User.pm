package App::WargamersPledge::Schema::Result::User;

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

App::WargamersPledge::Schema::Result::User

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 last

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "last",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 actions

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::Action>

=cut

__PACKAGE__->has_many(
  "actions",
  "App::WargamersPledge::Schema::Result::Action",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 auth_password

Type: might_have

Related object: L<App::WargamersPledge::Schema::Result::AuthPassword>

=cut

__PACKAGE__->might_have(
  "auth_password",
  "App::WargamersPledge::Schema::Result::AuthPassword",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->might_have(
  "auth_twitter",
  "App::WargamersPledge::Schema::Result::AuthTwitter",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 purchases

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::Purchase>

=cut

__PACKAGE__->has_many(
  "purchases",
  "App::WargamersPledge::Schema::Result::Purchase",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-02-18 06:36:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Mun5aH/xIzcRbZVj7vuAQw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
