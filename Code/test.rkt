;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define INPUT (list 1 2 3 4))

(define (powerSet L)
  (cond [(empty? L) (list empty)]
        [else (let ((powerSetOfRest (powerSet (rest L))))
                (append power-set-of-rest (map (lambda (subset) (cons (first L) subset)) 
                                               power-set-of-rest)))]))

(power-set INPUT)