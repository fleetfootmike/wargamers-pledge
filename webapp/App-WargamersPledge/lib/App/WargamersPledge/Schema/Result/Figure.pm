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

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 package

  data_type: 'integer'
  is_nullable: 0

=head2 scale

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 moderated

  data_type: 'tinyint'
  is_nullable: 1

=head2 manufacturer

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "package",
  { data_type => "integer", is_nullable => 0 },
  "scale",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "moderated",
  { data_type => "tinyint", is_nullable => 1 },
  "manufacturer",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 255 },
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

=head2 package_figures

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::PackageFigure>

=cut

__PACKAGE__->has_many(
  "package_figures",
  "App::WargamersPledge::Schema::Result::PackageFigure",
  { "foreign.figure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 purchases

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::Purchase>

=cut

__PACKAGE__->has_many(
  "purchases",
  "App::WargamersPledge::Schema::Result::Purchase",
  { "foreign.figure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-03-30 11:50:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:x6PKtnWEb8JGgWqS77ZOQw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
