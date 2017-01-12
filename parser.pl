use strict;
use warnings;

use LWP::Simple;
use Data::Dumper;

use utf8;

open(my $fh, '>:encoding(UTF-8)', 'output') or die "Could not open bla bla $!";

my $url = "http://www.milliyet.com.tr/reyhanli-da-bir-evde-patlama-oldu-gundem-2273965/";
my $content = get($url);

my $text = $1 if ($content =~ /<div itemprop=\"articleBody\">(.+?)<\/div>/gi);

$text =~ s/<.+?>//g;
print $fh $text;
