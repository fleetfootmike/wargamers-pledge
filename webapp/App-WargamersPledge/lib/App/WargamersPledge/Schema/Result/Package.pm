package App::WargamersPledge::Schema::Result::Package;

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

App::WargamersPledge::Schema::Result::Package

=cut

__PACKAGE__->table("package");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 moderated

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "moderated",
  { data_type => "tinyint", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 package_figures

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::PackageFigure>

=cut

__PACKAGE__->has_many(
  "package_figures",
  "App::WargamersPledge::Schema::Result::PackageFigure",
  { "foreign.package" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-03-30 11:50:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cBYOEzPNjnCTeF5r9L/hDQ

__PACKAGE__->many_to_many( figures => 'package_figures', 'figure');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
