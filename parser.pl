use strict;
use warnings;

use LWP::Simple;
use Tie::File; # Not required at all but i like using this
use Smart::Comments;
use Data::Dumper;

use utf8;

my ( $dataFileName ) = @ARGV;

if ( not defined $dataFileName ) {
	die "Need data file name";
}

tie my @dataRows, 'Tie::File', $dataFileName or die "Cannot initialize TieFile, $!";

open(my $fh, '>:encoding(UTF-8)', 'output') or die "Could not open bla bla $!";

for my $row (@dataRows) {
	my @urlPair = split ",", $row;
	my $url = $urlPair[1];
	my $content = get($url);

	my $parsedText;

	#-> headline #
	if ($content =~ /<h1 itemprop=\"headline\">(.+?)<\/h1>/) {
		$parsedText .= lc "$1  ";
	} else {
		### No headline found for: $url
	}

	#-> sub-headline #
	if ($content =~ /<h2 itemprop=\"description\">(.+?)<\/h2>/gi) {
		$parsedText .= lc "$1 ";
	} else {
		### No subheadline found for: $url
	}

	#-> articleBody #
	if ($content =~ /<div itemprop=\"articleBody\">(.+?)<\/div>/gi) {
		$parsedText .= lc $1;
		$parsedText =~ s/<.+?>//g;
	} else {
		$parsedText = $url . "\t<===";
	}

	print $fh "$parsedText\n";
}
