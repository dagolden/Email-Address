#!perl
use strict;
use warnings;

# This test graciously donated by Tatsuhiko Miyagawa.  All praise MIYAGAWA!

use Test::More;

plan skip_all => "Encode and Encode::MIME::Header required for these tests"
  unless eval { require Encode; require Encode::MIME::Header; 1 };

plan tests => 1;

use Email::Address;
use Encode;
use Encode::MIME::Header;

my $name = "\x{30c6}\x{30b9}\x{30c8}"; # "Test" in Unicode Japanese
my $mime = encode("MIME-Header", $name);

my $addr = Email::Address->new($mime => 'foo@example.com');
like $addr->format, qr/^=\?UTF-8/;
unlike $addr->format, qr/^"=\?/;

