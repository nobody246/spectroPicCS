Spectropic (c) 2020 Alex S. a.se8seven (a) g...m

GNU Public License v2

=======USAGE:=========

csi spc.scm [samps-per-sec ## in-file foo out-file bar chans # volume .## duration # pxMultiple #]

in-file: image file for input

out-file: wav file for output

chans: channels in wav file

volume: volume (<=1.0) for output sound

samps-per-sec: samples per second in generated wav file (default 11025)

threshold: the minimum combined added total of the RGB values of a pixel for said pixel to be transferred to the output wav file.

duration: duration of wav file 'pixel' at any given Y coordinate that meets threshold criteria along the X axis.

pxMultiple: The multiple for a Y coordinate that meets threshold criteria in the output wav file.

rotationOrientation: The number of times for imlib2 to rotate the input image. It is the parameter of the image-orientate command.

negative: 0 or 1 (default). If 1 then include only pixels in input image whose combined total RGB values are less than or equal to the threshold,if 0 then those with greater than or equal combined totals to the threshold.





**Example**


Same general idea as my spectropic project in python. In goes an image file, out comes a wav file containing the image to be viewed via spectrogram.


EX. for b.png being processed into b_output_negative_0.png and b_output_negative_1.png respectively

csi spc.scm negative 0 infile "b.png" volume .05 

and

csi spc.scm negative 1 infile "b.png" volume .05 



