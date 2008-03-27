
use strict;
use warnings;

use Test::More;
use Openvatar::URL;

plan tests => 4;

my $open_id = "http://gugod.org/";

is(
    openvatar_url(open_id => $open_id),
    'http://www.openvatar.com/avatar.php?openvatar_id=72ef21c5201f5bfe65ed4bede0a27515'
);

is(
    openvatar_url(open_id => $open_id, size => 50),
    'http://www.openvatar.com/avatar.php?openvatar_id=72ef21c5201f5bfe65ed4bede0a27515&size=50'
);

is(
    openvatar_url(
        open_id => $open_id,
        default => 'http://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/80px-Smiley.svg.png'
    ),
    'http://www.openvatar.com/avatar.php?openvatar_id=72ef21c5201f5bfe65ed4bede0a27515&default=http%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F8%2F85%2FSmiley.svg%2F80px-Smiley.svg.png'
);

is(
    openvatar_url(
        open_id => $open_id,
        default => 'http://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/80px-Smiley.svg.png',
        size => 60
    ),
    'http://www.openvatar.com/avatar.php?openvatar_id=72ef21c5201f5bfe65ed4bede0a27515&size=60&default=http%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F8%2F85%2FSmiley.svg%2F80px-Smiley.svg.png'
);
