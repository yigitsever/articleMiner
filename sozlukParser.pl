use strict;
use warnings;

use LWP::Simple;
use Smart::Comments;
use Data::Dumper;

use utf8;

my $url = 'http://www.buyukturkcesozluk.com/sozluk/Guncel_Turkce_Sozluk/32';

my $content = get($url);

my $cancelChar = chr(0x0094);
my $detailsChar = chr(0x0093);

if($content) {
	$content =~ s/[$cancelChar|$detailsChar]/"/g;
	while($content =~ /class="title">.*?>(.*?)<\/div>/gm) {
		my $lexema = $1;

		$lexema =~ /(.*?)<\/a><\/h2>(.*?)<i>/;
		print "Word: $1\nDefinition: $2\n";
	}
}
