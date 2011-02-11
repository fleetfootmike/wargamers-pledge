use strict;
use warnings;
use Test::More;


use Catalyst::Test 'App::WargamersPledge';
use App::WargamersPledge::Controller::Profile;

ok( request('/profile')->is_success, 'Request should succeed' );
done_testing();
