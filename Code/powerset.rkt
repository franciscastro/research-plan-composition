;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname powerset) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define INPUT (list 1 2 3 4 5))

;; Generate the power set of list L (all sublists in L)
(define (powerSet L)
  (cond [(empty? L) (list empty)]
        [else (let ((powerSetOfRest (powerSet (rest L))))
                (append powerSetOfRest (prepend (first L) powerSetOfRest)))]))

;; Prepend an element E to every element in L
;; Equivalent to: (map (lambda (subset) (cons (first L) subset)) powerSetOfRest)
(define (prepend E L)
  (cond [(empty? L) empty]
        [else (cons (append (list E) (first L)) (prepend E (rest L)))]))

(powerSet INPUT)