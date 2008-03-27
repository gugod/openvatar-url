
use strict;
use warnings;

use Test::More;
use Openvatar::URL;

plan tests => 3;

my $open_id = "http://gugod.org/";

my $id  = openvatar_id($open_id);

my $url1 = openvatar_url(open_id => $open_id);
my $url2 = openvatar_url(id => $id);

is($id, '72ef21c5201f5bfe65ed4bede0a27515');
is($url1, 'http://www.openvatar.com/avatar.php?openvatar_id=72ef21c5201f5bfe65ed4bede0a27515');
is($url2, 'http://www.openvatar.com/avatar.php?openvatar_id=72ef21c5201f5bfe65ed4bede0a27515');
