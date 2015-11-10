#
#===============================================================================
#
#         FILE: Overview.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Sergey Magochkin (), magaster@gmail.com
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 11/10/2015 15:33:37
#     REVISION: ---
#===============================================================================
package My::Overview;

use strict;
use warnings;
use Image::Magick;
use Exporter qw(import);
use File::Path 'remove_tree';

our @EXPORT_OK = qw(clean_dir postwork_img make_tiles);
our $VERSION = 0.01;
our %EXPORT_TAGS = (
    all => [
        qw(clean_dir postwork_img make_tiles)
    ]
);

sub clean_dir {
    my ($my_save_dir) = @_;
    remove_tree($my_save_dir) if -e $my_save_dir;
}

sub postwork_img {
    my $path_file = shift;
    my $path_output = shift;
    my $image = Image::Magick->new;
    my $tmp;
    $tmp = $image->Read($path_file);
    $tmp = $image->Rotate(degrees=>90);
    $tmp = $image->AdaptiveResize(900);
    $tmp = $image->Write($path_output);
}

sub make_tiles {
    my $path_output = shift;
    my (@path_array_file) = @_;
    my $image = Image::Magick->new;
    my $tmp;
    $tmp = $image->Read(@path_array_file);
    print $tmp;
    my $montage = $image->Montage(Tile=>2, geometry => 900);
    $montage->Write($path_output);
}

1;
