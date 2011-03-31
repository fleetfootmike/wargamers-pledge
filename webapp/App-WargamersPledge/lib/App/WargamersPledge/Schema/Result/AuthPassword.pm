package App::WargamersPledge::Schema::Result::AuthPassword;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("EncodedColumn", "InflateColumn::DateTime");

=head1 NAME

App::WargamersPledge::Schema::Result::AuthPassword

=cut

__PACKAGE__->table("auth_password");

=head1 ACCESSORS

=head2 user

  data_type: 'varchar'
  default_value: (empty string)
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "user" => {
    data_type => "varchar",
    default_value => "",
    is_foreign_key => 1,
    is_nullable => 0,
    size => 255,
  },
  "password" => {
    data_type => "varchar",
    is_nullable => 0,
    size => 255,
    encode_column => 1,
    encode_class  => 'Crypt::Eksblowfish::Bcrypt',
    encode_args   => { key_nul => 0, cost => 8 },
    encode_check_method => 'check_password',
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


# Created by DBIx::Class::Schema::Loader v0.07007 @ 2011-03-30 14:49:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jOe5Hf5dRUWhZLSe7QolPw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
