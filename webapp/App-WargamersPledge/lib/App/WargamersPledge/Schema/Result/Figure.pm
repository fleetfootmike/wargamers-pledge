package App::WargamersPledge::Schema::Result::Figure;

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

App::WargamersPledge::Schema::Result::Figure

=cut

__PACKAGE__->table("figure");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 manufacturer

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=head2 scale

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "manufacturer",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 255 },
  "scale",
  { data_type => "varchar", is_nullable => 1, size => 15 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 manufacturer

Type: belongs_to

Related object: L<App::WargamersPledge::Schema::Result::Manufacturer>

=cut

__PACKAGE__->belongs_to(
  "manufacturer",
  "App::WargamersPledge::Schema::Result::Manufacturer",
  { id => "manufacturer" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-02-17 06:27:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/wdD4be0r/5W8ydzrcZ0mQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
