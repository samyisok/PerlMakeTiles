# PerlMakeTiles 

How to use:

    ./maker_tiles.pl --save save_output_file.jpg  /Volumes/share/scans/CCF10112015*


Input:

    $mediainfo /Volumes/share/scans/CCF10112015* | egrep "Width|Height" | head -2
    Width                                    : 2 412 pixels
    Height                                   : 3 437 pixels
    $ ls  /Volumes/share/scans/CCF10112015* | wc -l
    17

Output:

    $mediainfo save_output_file.jpg | egrep "Width|Height"
    Width                                    : 1 800 pixels
    Height                                   : 5 688 pixels
