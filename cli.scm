;Spectropic (c) 2020 Alex S. a.se8seven (a) g...m
;GNU Public License v2
(define expected-args
  '(samps-per-sec infile outfile chans volume duration pxMultiple threshold rotationOrientation negative))
(define current-arg '())
(define argc (length cli-args))
(define (usage)
  (print "Spectropic (c) 2020 Alex S. a.se8seven (a) g...m")
  (print "GNU Public License v2")
  (print "=======USAGE:=========")
  (print
   "csi spc.scm [samps-per-sec ## in-file foo out-file bar chans # volume .## duration # pxMultiple #]\n"
   "in-file: image file for input\n"
   "out-file: wav file for output\n"
   "chans: channels in wav file\n"
   "volume: volume (<=1.0) for output sound\n"
   "samps-per-sec: samples per second in generated wav file (default 11025)\n"
   "threshold: the minimum combined added total of the RGB values of a pixel for said pixel to be transferred to the output wav file.\n"
   "duration: duration of wav file 'pixel' at any given Y coordinate that meets threshold criteria along the X axis.\n"
   "pxMultiple: The multiple for a Y coordinate that meets threshold criteria in the output wav file.\n"
   "rotationOrientation: The number of times for imlib2 to rotate the input image. It is the parameter of the image-orientate command.\n")
  (exit))
(define (parse-cli args)
  (when (not (null? args))
    (let ((arg (car args)))
      (if (= (remainder argc 2) 0)
	  (let ((param-name arg)
		(a 0))
	    (for-each (lambda (x)
			(when (equal? (symbol->string x) param-name)
			  (set! a (add1 a))))
		      expected-args)
	    (when (= a 0)
	      (usage))
	    (set! current-arg (string->symbol param-name)))
	  (cond ((eq? current-arg 'samps-per-sec)
		 (set! s-per-sec (string->number arg)))
                ((eq? current-arg 'infile)
                 (set! in-file arg))
                ((eq? current-arg 'outfile)
                 (set! out-file arg))
                ((eq? current-arg 'chans)
                 (set! chans (string->number arg)))
                ((eq? current-arg 'volume)
                 (set! volume (string->number arg)))
                ((eq? current-arg 'duration)
                 (set! duration (string->number arg)))
                ((eq? current-arg 'px-multiple)
                 (set! pixel-multiple (string->number arg)))
                ((eq? current-arg 'threshold)
                 (set! threshold (string->number arg)))
                ((eq? current-arg 'rotationOrientation)
                 (set! orient (string->number arg)))
                ((eq? current-arg 'negative)
                 (if (equal? arg "1")
                     (set! _OP <=)
                     (set! _OP >=)))))
      (set! argc (add1 argc))
      (parse-cli (cdr args)))))

