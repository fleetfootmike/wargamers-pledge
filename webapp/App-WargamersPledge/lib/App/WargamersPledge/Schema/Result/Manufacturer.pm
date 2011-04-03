package App::WargamersPledge::Schema::Result::Manufacturer;

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

App::WargamersPledge::Schema::Result::Manufacturer

=cut

__PACKAGE__->table("manufacturer");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 moderated

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "moderated",
  { data_type => "tinyint", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 figures

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::Figure>

=cut

__PACKAGE__->has_many(
  "figures",
  "App::WargamersPledge::Schema::Result::Figure",
  { "foreign.manufacturer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 packages

Type: has_many

Related object: L<App::WargamersPledge::Schema::Result::Package>

=cut

__PACKAGE__->has_many(
  "packages",
  "App::WargamersPledge::Schema::Result::Package",
  { "foreign.manufacturer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-04-03 23:06:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RBqGDyGOoB7pP9eaNtwvNA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
