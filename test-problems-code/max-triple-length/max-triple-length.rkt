;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname max-triple-length) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Francisco Enrique Vicente G. Castro
;; Last update: 25 September 2015

#|
Length of Triples

Design a program called maxTripleLength that consumes a list of strings and 
produces the length of the longest concatenation of three consecutive elements.
Assume the input contains at least three strings.

Example: 
maxTripleLength(["a", "bb", "c", "dd"]) yields 5 (from "bb", "c", and "dd")
|#

;; Input: A list of strings: L - list of strings
;; Output: A string which is a concatenation of the elements of L
(define (build-string-from-list L)
  (cond [(empty? L) "" ]
        [else (string-append (first L) (build-string-from-list (rest L)))]))

;; Input: (1) A number denoting the size of the original list passed: OLS - original list size
;;        (2) A list of strings (reduced in size later): L - list of strings
;; Output: A list of strings with 3 elements
(define (build-list-of-three OLS L)
  (cond [(empty? L) empty]
        [else (cond [(= (- OLS (length L)) 3) empty]
                    [else (append (list (first L)) (build-list-of-three OLS (rest L)))])]))


;; Input: A list of strings: L - list of strings
;; Output: The length of the longest concatenation of 3 consecutive elements
(define (maxtriplelength L)
  (cond [(empty? L) 0]
        [else (cond [(> (string-length (build-string-from-list (build-list-of-three (length L) L))) (maxtriplelength (rest L)))
                     (string-length (build-string-from-list (build-list-of-three (length L) L)))]
                    [else (maxtriplelength (rest L))])]))


(define STRINGLIST (list "a" "bb" "c" "dd"))
(define STRINGLIST1 (list "a" "bb" "c" "dd" "e" "f" "gg" "hh" "iii"))
;(build-string-from-list STRINGLIST)
;(build-list-of-three (length STRINGLIST) STRINGLIST)

;(check-expect (maxtriplelength STRINGLIST) 5)
;(check-expect (build-list-of-three (length STRINGLIST) STRINGLIST) (list "a" "bb" "c"))
(maxtriplelength STRINGLIST)
(maxtriplelength STRINGLIST1)


