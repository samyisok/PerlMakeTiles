#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: maker_tiles.pl
#
#        USAGE: ./maker_tiles.pl
#
#  DESCRIPTION:
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Sergey Magochkin (), magaster@gmail.com
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 11/10/2015 19:11:33
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use File::Basename qw(fileparse);
use FindBin;
use lib "$FindBin::Bin/lib";
use My::Overview qw(:all);
use Getopt::Long;

my $tmp_dir    = '/tmp/tmp-tiles';
my $save_tiles = './output_tiles.jpg';
GetOptions( "save=s" => \$save_tiles )
  or die "invalid arguments, \n Usage: ./maker_tiles.pl --save output.jpg";

my (@list_img) = @ARGV;

mkdir $tmp_dir unless -e $tmp_dir;

foreach my $filepath (@list_img) {
    my $filename  = fileparse($filepath);
    my $save_path = $tmp_dir . "/" . $filename;
    postwork_img( $filepath, $save_path );
}

my @tmp_files = glob("$tmp_dir/*.jpg");

make_tiles( $save_tiles, @tmp_files );

clean_dir($tmp_dir)

