use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Openvatar/URL.pm';

build_requires  'Test::More'        => '0.42';
requires
    'URI::Escape' => 0,
    'Digest::MD5' => 0,
    'Carp' => 0,
    'Exporter' => 0;

WriteAll;


