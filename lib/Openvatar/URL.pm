package Openvatar::URL;

use warnings;
use strict;
use Carp;
use URI::Escape qw(uri_escape);
use Digest::MD5 qw(md5_hex);

use Exporter;
BEGIN {
    our @ISA    = qw(Exporter);
    our @EXPORT = qw( openvatar_id openvatar_url );
    our $VERSION = '0.0.2';
}

my $base = 'http://www.openvatar.com/avatar.php';

sub openvatar_id {
    return md5_hex(shift);
}

sub openvatar_url {
    my %args = @_;

    exists $args{id} or exists $args{open_id} or 
        croak "Cannot generate a Openvatar URI without an openid or openvatar id";

    exists $args{id} xor exists $args{open_id} or
        croak "Both an id and an openid were given.  openvatar_url() only takes one";

    if ( exists $args{size} ) {
        $args{size} >= 1 and $args{size} <= 80
            or croak "Openvatar size must be 1 .. 80";
    }

    $args{openvatar_id} = $args{id} || openvatar_id($args{open_id});

    $args{default} = uri_escape($args{default}) if $args{default};

    my @pairs;
    for (qw(openvatar_id size default)) {
        next unless exists $args{$_};
        push @pairs, join("=", $_, $args{$_});
    }

    my $uri = join(
        "?",
        $base,
        join("&", @pairs)
    );

    return $uri;
}



1;
__END__

=head1 NAME

Openvatar::URL - Make URLs for Openvatars from an OpenID


=head1 VERSION

This document describes Openvatar::URL version 0.0.1


=head1 SYNOPSIS

    use Openvatar::URL;

    my $openvatar_id = openvatar_id($open_id);

    my $openvatar_url = openvatar_url(open_id => $open_id);

=head1 DESCRIPTION

Openvatar is your Openid avatar image (80x80). Your avatar appear
beside your name when you participate (comments or other contents) on
Openvatar enabled sites. This service is provided by http://www.openvatar.com/.

=head1 INTERFACE 

=over

=item openvatar_url(open_id => $open_id, %options)

Constructs a URL to fetch openvatar for given C<$open_id> or C<$id>.

C<$id> is a openvatar id, see L</openvatar_id> for mor information

C<%options> are optional and are...

=over

=item size

Specifies the wanted width and height of the openvatar. It's always a
squre image.

Valid values are from 1 to 80 inclusive.

    size => 40, # 40x40 image

=item default

The url to use if the given id has no openvatar.

    default => "http://upload.wikimedia.org/wikipedia/en/8/89/Alfred.jpg"

=back

=item openvatar_id($open_id)

Converts an C<$open_id> into its Openvatar C<%id>.

=back

=head1 CONFIGURATION AND ENVIRONMENT

Openvatar::URL requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-openvatar-url@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 SEE ALSO

L<Gravatar::URL> - Another global avatar perl module.

L<http://www.openvatar.com/> - The actual service provider.

=head1 AUTHOR

Kang-min Liu  C<< <gugod@gugod.org> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Kang-min Liu C<< <gugod@gugod.org> >>.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
