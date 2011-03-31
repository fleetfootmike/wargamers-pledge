package App::WargamersPledge::Schema::Result::Action;

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

App::WargamersPledge::Schema::Result::Action

=cut

__PACKAGE__->table("action");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 purchase

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 use_as

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 num

  data_type: 'integer'
  is_nullable: 1

=head2 user

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 done

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 notes

  data_type: 'tinytext'
  is_nullable: 1

=head2 action

  data_type: 'enum'
  extra: {list => ["painted"]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "purchase",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "use_as",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "num",
  { data_type => "integer", is_nullable => 1 },
  "user",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "done",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "notes",
  { data_type => "tinytext", is_nullable => 1 },
  "action",
  { data_type => "enum", extra => { list => ["painted"] }, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

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

=head2 purchase

Type: belongs_to

Related object: L<App::WargamersPledge::Schema::Result::Purchase>

=cut

__PACKAGE__->belongs_to(
  "purchase",
  "App::WargamersPledge::Schema::Result::Purchase",
  { id => "purchase" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-03-30 14:38:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jMoLWZrY/feszb/6bPympQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
