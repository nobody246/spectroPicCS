# spectroPicChickenScheme

Same general idea as my spectropic project in python. In goes an image file, out comes a wav file containing the image to be viewed via spectrogram.


EX. for b.png being processed into b_output_negative_0.png and b_output_negative_1.png respectively

csi spc.scm negative 0 infile "b.png" volume .05 pxMultiple 10

and

csi spc.scm negative 1 infile "b.png" volume .05 pxMultiple 10



