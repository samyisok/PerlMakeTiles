#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 01-common.pl
#
#        USAGE: ./01-common.pl
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
#      CREATED: 11/10/2015 16:04:39
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Test::More;
use File::Spec;
use Test::Files;
use File::Path 'remove_tree';
use_ok q{My::Overview};
my @subs = qw(clean_dir postwork_img make_tiles);
can_ok q{My::Overview}, @subs;
use_ok q{My::Config};

our $output_dir = "./test-output";

sub make_content {
    my ($name_file) = @_;
    open( my $fh, '<', $name_file ) or die "can't open file $!";
    my $file_content;
    while ( readline($fh) ) {
        $file_content .= $_;
    }
    close $fh;
    return $file_content;

}

sub clean_dir {
    my ($my_save_dir) = @_;
    remove_tree($my_save_dir) if -e $my_save_dir;
}

subtest 'check postwork' => sub {
    my $config = Config->new(
        rotate_degree => 90,
        tile_width    => 900,
    );

    clean_dir($output_dir);
    mkdir $output_dir;

    my $img_input    = './test-input/CCF10112015.jpg';
    my $img_output   = './test-output/postwork.jpg';
    my $img_expected = './test-expected/postwork.jpg';

    My::Overview::postwork_img( $img_input, $img_output, $config );
    ok( sub { return 1 if -e $img_output }, "File exist, ok" );
    my $expected_file = make_content($img_expected);
    my $output_file   = make_content($img_output);
    ok( $expected_file eq $output_file, "File postwork ok" );
};

subtest 'Make postwork' => sub {
    my $config = Config->new(
        rotate_degree    => 90,
        tile_width       => 900,
        input_pics_array => [
            qw(./test-input/CCF10112015.jpg ./test-input/CCF10112015_2.jpg
            ./test-input/CCF10112015_3.jpg ./test-input/CCF10112015_4.jpg)
        ],
        tmp_dir_path => './test-output'
    );
    My::Overview::make_postwork($config);
    ok(
        make_content("./test-output/CCF10112015.jpg") eq
          make_content("./test-expected/CCF10112015.jpg"),
        "File1 postwork ok"
    );
    ok(
        make_content("./test-output/CCF10112015_2.jpg") eq
          make_content("./test-expected/CCF10112015_2.jpg"),
        "File2 postwork ok"
    );
    ok(
        make_content("./test-output/CCF10112015_3.jpg") eq
          make_content("./test-expected/CCF10112015_3.jpg"),
        "File3 postwork ok"
    );
    ok(
        make_content("./test-output/CCF10112015_4.jpg") eq
          make_content("./test-expected/CCF10112015_4.jpg"),
        "File4 postwork ok"
    );
};

subtest 'Make Tile' => sub {
    my $img_output = './test-output/tiles.jpg';
    my $config     = Config->new(
        postwork_pics_array => [
            qw(./test-input/CCF10112015.jpg ./test-input/CCF10112015_2.jpg 
            ./test-input/CCF10112015_3.jpg ./test-input/CCF10112015_4.jpg)
        ],
        tile_width     => 900,
        tile_count     => 2,
        save_file_path => $img_output,
    );
    my $img_expected = './test-expected/tiles.jpg';
    My::Overview::make_tiles($config);
    ok( sub { return 1 if -e $img_output }, "File exist, ok" );
    my $expected_file = make_content($img_expected);
    my $output_file   = make_content($img_output);
    ok( $expected_file eq $output_file, "File postwork ok" );
};

clean_dir($output_dir);

done_testing();
