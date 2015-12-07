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
use FindBin;
use lib "$FindBin::Bin/lib";
use My::Overview qw(:all);
use My::Config;
use Getopt::Long;

my $tmp_dir    = '/tmp/tmp-tiles';
my $save_tiles = './output_tiles.jpg';
my $rotate     = 0;
my $pic_wd     = 900;
my $tiles      = 2;
GetOptions(
    "save=s"   => \$save_tiles,
    "rotate=i" => \$rotate,
    "width=i"  => \$pic_wd,
    "tiles=i"  => \$tiles,
) or die "invalid arguments, \n Usage: ./maker_tiles.pl --save output.jpg";

die "Empty pic list" unless @ARGV;

my $config = Config->new(
    tmp_dir_path     => $tmp_dir,
    save_file_path   => $save_tiles,
    tile_count       => $tiles,
    tile_width       => $pic_wd,
    rotate_degree    => $rotate,
    input_pics_array => \@ARGV,
);


mkdir $config->get_tmp_dir_path unless -e $config->get_tmp_dir_path;
make_postwork($config);
my @tmp_files = glob($config->get_tmp_dir_path . "/*");
$config->set_postwork_pics_array(\@tmp_files);
make_tiles($config);
clean_dir( $config->get_tmp_dir_path )

