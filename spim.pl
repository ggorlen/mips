#!/usr/bin/perl

use strict;
use warnings;


# TODO need a way to pass stdin stdout interactively https://www.perlmonks.org/?node_id=939017
my $fname = $ARGV[0] or die "Fatal: please provide a MIPS file to run";
my $output = `spim -f $fname`;
$output =~ s/SPIM Version 8\.0 of January 8, 2010\nCopyright 1990-2010, James R\. Larus\.\nAll Rights Reserved\.\nSee the file README for a full copyright notice\.\nLoaded: \/usr\/lib\/spim\/exceptions\.s\n//g;
print "$output\n";
