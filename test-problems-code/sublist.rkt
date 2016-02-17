;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sublist) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define INPUT (list 1 2 3 4))

;;======================================================================
;; Generate singletons
(define (singleton L)
  (map list INPUT))

;; Generate singletons without map()
(define (singleton1 L)
  (cond [(empty? L) (list empty)]
        [else (cons (list (first L)) (singleton1 (rest L)))]))
;;======================================================================

;;======================================================================
(define SINGLETONS (singleton INPUT))

;; Generate sublists for the CURR element
(define (build CURR L)
  (cond [(empty? L) empty]
        [else (cond [(empty? L) empty]
                    [else (cons (append CURR (first L)) (build CURR (rest L)))])]))

;(build (first SINGLETONS) (rest SINGLETONS))

;; Generate sublists for each element in L
(define (build-each L)
  (cond [(= 1 (length L)) empty]
        [else (append (build (first L) (rest L)) (build-each (rest L)))]))

;(build-each SINGLETONS)
;;======================================================================

;;======================================================================

;;======================================================================