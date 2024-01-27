#!/usr/bin/perl

use strict;
use warnings;

# Get my hostname
my $hostname = `hostname`;

# Split the hostname
my @parts = split /\./, $hostname;

# Print first part
print "$parts[0]";
