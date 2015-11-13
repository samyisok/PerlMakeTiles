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
use File::Basename qw(fileparse);

   
our @EXPORT_OK = qw(clean_dir postwork_img make_tiles make_postwork);
our $VERSION = 0.01;
our %EXPORT_TAGS = (
    all => [
        qw(make_postwork clean_dir postwork_img make_tiles)
    ]
);

sub clean_dir {
    my ($my_save_dir) = @_;
    remove_tree($my_save_dir) if -e $my_save_dir;
}

sub postwork_img {
    my $path_file = shift;
    my $path_output = shift;
    my $config = shift;
    my $image = Image::Magick->new;
    my $tmp;
    $tmp = $image->Read($path_file);
    $tmp = $image->Rotate(degrees=>$config->get_rotate_degree);
    $tmp = $image->AdaptiveResize($config->get_tile_width);
    $tmp = $image->Write($path_output);
}

sub make_postwork {
    my $config = shift;
    foreach my $filepath ( @{$config->get_input_pics_array}) {
        my $filename  = fileparse($filepath);
        my $save_path = $config->get_tmp_dir_path . "/" . $filename;
        postwork_img( $filepath, $save_path, $config );
    }
}


sub make_tiles {
    my $config = shift;
    my $image = Image::Magick->new;
    my $tmp = $image->Read(@{$config->get_postwork_pics_array});
    my $montage = $image->Montage(Tile=>$config->get_tile_count, geometry => $config->get_tile_width);
    $montage->Write($config->get_save_file_path);
}

1;
