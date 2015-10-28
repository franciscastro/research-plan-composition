;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname max-triple-length1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; Output: The length of the longest concatenation of three consecutive strings in L
(define (maxTripleLength L)
  (cond [(empty? L) empty]
        [(< (length L) 3) "List has < 3 elements"]
        [else (lengthLongestConcat (allConcats L))]))

;; DATA TRANSFORMATION
;; ==================================================

;; Input: A list of strings: L - list of strings
;; Output: A list of all concatenations in L of 3 successive strings
(define (allConcats L)
  (cond [(empty? L) empty]
        [else (cond [(< (length L) 3) empty]
                    [else (cons (concatThreeStrings L) (allConcats (rest L)))])]))

;; Input: A list of strings: L - list of strings
;; Output: A string that's a concatenation of the first 3 strings in L
(define (concatThreeStrings L)
  (local [(define (concatThree L COUNT)
            (cond [(= 3 COUNT) ""]
                  [else (string-append (first L) (concatThree (rest L) (+ 1 COUNT)))]))]
    (concatThree L 0)))

;; ==================================================

;; DATA PROCESSING
;; ==================================================

;; Input: A list of strings: L - list of strings
;; Output: The length of the longest string in L
(define (lengthLongestConcat L)
  (local [(define (findLongest L LONGEST)
            (cond [(empty? L) LONGEST]
                  [else (cond [(> (string-length (first L)) LONGEST) (findLongest (rest L) (string-length (first L)))]
                              [else (findLongest (rest L) LONGEST)])]))]
    (findLongest L 0)))

;; ==================================================

(define S1 (list "a" "bb" "c" "dd"))
(define S2 (list "a" "bb" "c" "dd" "e" "f" "gg" "hh" "iii"))
(define S3 (list "bb" "c" "dd" "a"))
(define S4 (list "a" "bb"))

;(concatThreeStrings S1)
;(allConcats S1)
;(lengthLongestConcat (allConcats S1))

;(concatThreeStrings S2)
;(allConcats S2)
;(lengthLongestConcat (allConcats S2))

;(concatThreeStrings S3)
;(allConcats S3)
;(lengthLongestConcat (allConcats S3))

(maxTripleLength S1)
(maxTripleLength S2)
(maxTripleLength S3)
(maxTripleLength S4)