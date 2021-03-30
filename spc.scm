;Spectropic (c) 2020 Alex S. a.se8seven (a) g...m
;GNU Public License v2
(use sndfile imlib2)
(define cli-args (command-line-arguments))
(include "cli.scm")
(define 2pi  (* 2 (acos -1.0)))
(define s-per-sec 11025)
(define in-file "in.jpg")
(define out-file "out.wav")
(define chans 1)
(define volume .05)
(define duration 500)
(define threshold 300)
(define orient 6)
(define _OP <=)
(define pixel-multiple 50)
(parse-cli cli-args)
(when (not (file-exists? in-file))
  (print "error input file not found")
  (exit))
(define img
  (let ((flip (lambda (x) (image-orientate x orient))))
    (flip (image-load in-file))))
(define imgw (image-width img))
(define imgh (image-height img))
(define (precalc-wave-part freq)
  (* 2pi freq))
(define lst '())
(define (set-current-freqs args)
  (set! lst
    (map precalc-wave-part args)))
(define (process-img x)
  (let r ((y 0)
          (f-list '()))
    (define-values (_r _g _b _a)
      (image-pixel/rgba img x y))
    (when (_OP (+ _r _g _b) threshold)
      (set! f-list
        (append f-list `(,(* y pixel-multiple)))))
    (if (< y (sub1 imgh))
        (r (add1 y) f-list)
        (append '(0) f-list))))
(define (make-wav w h #!optional (c 0))
  (set-current-freqs (process-img c))
  (let r ((a 0))
    (when (< a duration)
      (w h (list->f32vector
            `(,(* volume
                  (apply
                   +
                   (map
                    (lambda (x)
                      (sin
                       (/ (* x (+ a c))
                          s-per-sec)))
                    lst))))))
      (r (add1 a))))
  (when (< c (sub1 imgw))
    (make-wav w h (add1 c))))
(with-sound-to-file
 out-file
 '(wav pcm-16 file)
 s-per-sec
 chans
 (lambda (h)
   (make-wav write-items/f32
             h)))
(exit)
