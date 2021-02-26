Spectropic (c) 2020 Alex S. a.se8seven (a) g...m
================================================

GNU Public License v2

=======USAGE:=========

csi spc.scm [samps-per-sec ## in-file foo out-file bar chans # volume .## duration # px-multiple # threshold # rotation-orientation #]

in-file: image file for input

out-file: wav file for output

volume: volume (<=1.0) for output sound

samps-per-sec: samples per second in generated wav file (default 11025)

threshold: the minimum combined added total of the RGB values of a pixel for said pixel to be transferred to the output wav file.

duration: duration of wav file 'pixel' at any given Y coordinate that meets threshold criteria along the X axis.

px-multiple: The multiple for a Y coordinate that meets threshold criteria in the output wav file.

rotation-orientation: The number of times for imlib2 to rotate the input image. It is the parameter of the image-orientate command.

negative: 0 or 1 (default). If 1 then include only pixels in input image whose combined total RGB values are less than or equal to the threshold, if 0 then those with greater than or equal combined totals to the threshold.


=============================





**Example**


Same general idea as my spectropic project in python. In goes an image file, out comes a wav file containing the image to be viewed via spectrogram.


EX. for b.png being processed into the spectrograms seen in b_output_negative_0.png and b_output_negative_1.png respectively

csi spc.scm negative 0 in-file "b.png" volume .05 

and

csi spc.scm negative 1 in-file "b.png" volume .05 

EX. for in.jpg being processed into the spectrograms seen in output_negative_0_threshold_600_volume_07.png and output_negative_1_threshold_600_volume_07.png respectively

csi spc.scm negative 0 in-file "in.jpg" out-file foo.wav volume .07 threshold 600

and

csi spc.scm negative 1 in-file "in.jpg" out-file foo.wav volume .07 threshold 600

