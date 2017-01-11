use strict;
use warnings;

use HTML::TokeParser::Simple;
use Data::Dumper;
use utf8;

my $parser = HTML::TokeParser::Simple->new(url => 'http://www.milliyet.com.tr/gaziantep-te-patlama--gundem-2237209/');

my @contents;

while ( my $div = $parser->get_tag('div') ) {
	my $id = $div->get_attr('itemprop');
	next unless defined($id) and $id eq 'articleBody';

	push @contents, $div;
}

print Dumper \@contents;
