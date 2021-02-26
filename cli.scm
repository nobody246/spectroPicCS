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
   "csi spc.scm [samps-per-sec ## infile foo outfile bar chans # volume .## duration # pxMultiple #]\n"
   "infile: image file for input\n"
   "outfile: wav file for output\n"
   "chans: channels in wav file\n"
   "volume: volume (<=1.0) for output sound\n"
   "samps-per-sec: samples per second in generated wav file (default 11025)\n"
   "threshold: the minimum combined added total of the RGB values of a pixel for said pixel to be transferred to the output wav file.\n"
   "duration: duration of wav file 'pixel' at any given Y coordinate that meets threshold criteria along the X axis.\n"
   "pxMultiple: The multiple for a Y coordinate that meets threshold criteria in the output wav file.\n"
   "rotationOrientation: The number of times for imlib2 to rotate the input image. It is the parameter of the image-orientate command.\n"
   "negative: 0 or 1 (default). If 1 then include only pixels in input image whose combined total RGB values are less than or equal to the threshold,\n"
   "if 0 then those with greater than or equal combined totals to the threshold.\n")
  (exit))
(define (parse-cli args)
  (when (not (null? args))
    (let* ((arg (car args))
           (arg-num (string->number arg)))
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
	  (cond ((and (eq? current-arg 'samps-per-sec) (number? arg-num))
		 (set! s-per-sec arg-num))
                ((eq? current-arg 'infile)
                 (set! in-file arg))
                ((eq? current-arg 'outfile)
                 (set! out-file arg))
                ((and (eq? current-arg 'chans) (number? arg-num))
                 (set! chans arg-num))
                ((and (eq? current-arg 'volume) (number? arg-num))
                 (set! volume arg-num))
                ((and (eq? current-arg 'duration) (number? arg-num))
                 (set! duration arg-num))
                ((and (eq? current-arg 'pxMultiple) (number? arg-num))
                 (set! pixel-multiple arg-num))
                ((and (eq? current-arg 'threshold) (number? arg-num))
                 (set! threshold arg-num))
                ((and (eq? current-arg 'rotationOrientation) (number? arg-num))
                 (set! orient arg-num))
                ((eq? current-arg 'negative)
                 (if (equal? arg "1")
                     (set! _OP <=)
                     (set! _OP >=)))))
      (set! argc (add1 argc))
      (parse-cli (cdr args)))))

