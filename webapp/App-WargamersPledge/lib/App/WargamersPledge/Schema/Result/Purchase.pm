package App::WargamersPledge::Schema::Result::Purchase;

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

App::WargamersPledge::Schema::Result::Purchase

=cut

__PACKAGE__->table("purchase");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 num

  data_type: 'integer'
  is_nullable: 0

=head2 user

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 figure

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 acquired

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 notes

  data_type: 'tinytext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "num",
  { data_type => "integer", is_nullable => 0 },
  "user",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "figure",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "acquired",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "notes",
  { data_type => "tinytext", is_nullable => 1 },
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
  { "foreign.purchase" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 figure

Type: belongs_to

Related object: L<App::WargamersPledge::Schema::Result::Figure>

=cut

__PACKAGE__->belongs_to(
  "figure",
  "App::WargamersPledge::Schema::Result::Figure",
  { id => "figure" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-04-28 16:45:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yLoOrkoOB5H1WIuC0X9aSQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
