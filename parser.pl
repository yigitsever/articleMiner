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

	my $text = $1 if ($content =~ /<div itemprop=\"articleBody\">(.+?)<\/div>/gi);
	if (not defined $text) {
		$text = $url . "\t<===";
	} else {
		$text =~ s/<.+?>//g;
	}

	print $fh "$text\n";
}
