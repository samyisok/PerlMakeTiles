package Config;
use strict;
use warnings;
use Moose;

has 'tmp_dir_path' => (
    is     => 'rw',
    isa    => 'Str',
    reader => 'get_tmp_dir_path',
    writer => 'set_tmp_dir_path',
);

has 'save_file_path' => (
    is     => 'rw',
    isa    => 'Str',
    reader => 'get_save_file_path',
    writer => 'set_save_file_path',
);

has 'input_pics_array' => (
    is     => 'rw',
    isa    => 'ArrayRef',
    reader => 'get_input_pics_array',
    writer => 'set_input_pics_array',
);


has 'postwork_pics_array' => (
    is     => 'rw',
    isa    => 'ArrayRef',
    reader => 'get_postwork_pics_array',
    writer => 'set_postwork_pics_array',
);

has 'rotate_degree' => (
    is     => 'rw',
    isa    => 'Int',
    reader => 'get_rotate_degree',
    writer => 'set_rotate_degree',
);

has 'tile_count' => (
    is     => 'rw',
    isa    => 'Int',
    reader => 'get_tile_count',
    writer => 'set_tile_count',
);

has 'tile_width' => (
    is     => 'rw',
    isa    => 'Int',
    reader => 'get_tile_width',
    writer => 'set_tile_width',
);

1;
