package App::WargamersPledge::Schema::Result::PackageFigure;

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

App::WargamersPledge::Schema::Result::PackageFigure

=cut

__PACKAGE__->table("package_figure");

=head1 ACCESSORS

=head2 package

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 figure

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 count

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "package",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "figure",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "count",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("package", "figure");

=head1 RELATIONS

=head2 figure

Type: belongs_to

Related object: L<App::WargamersPledge::Schema::Result::Figure>

=cut

__PACKAGE__->belongs_to(
  "figure",
  "App::WargamersPledge::Schema::Result::Figure",
  { id => "figure" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 package

Type: belongs_to

Related object: L<App::WargamersPledge::Schema::Result::Package>

=cut

__PACKAGE__->belongs_to(
  "package",
  "App::WargamersPledge::Schema::Result::Package",
  { id => "package" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-03-30 14:49:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gxWbuexbby2BYixU/wVTRw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
