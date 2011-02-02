use strict;
use warnings;
use Test::More;


use Catalyst::Test 'App::WargamersPledge';
use App::WargamersPledge::Controller::Root;

ok( request('/root')->is_success, 'Request should succeed' );
done_testing();
