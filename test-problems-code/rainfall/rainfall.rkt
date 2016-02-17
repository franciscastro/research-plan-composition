;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname rainfall) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
#|Rainfall

Design a program called rainfall that consumes a list of real numbers representing daily rainfall readings.
The list may contain the number -999 indicating the end of the data of interest.
Produce the average of the non-negative values in the list up to the first -999 (if it shows up).
There may be negative numbers other than -999 in the list (representing faulty readings).

Example: rainfall([1, -2, 5, -999, 8]) yields 3
|#

;; rainfall: List[Number] -> Number
;; Consume: A list of numbers
;; Produce: The average of all non-negative numbers before a sentinel (if present)
(define (rainfall L)
 (cond [(empty? L) empty]
       [else (compute-average (clean-input L))]))


;; compute-average: List[Number] -> Number
;; Consume: A list of numbers
;; Produce: The average of all values in the list
(define (compute-average L)
  (/ (sum-positives L) (length L)))


;; sum-positives: List[Number] -> Number
;; Consume: A list of numbers
;; Produce: The sum of all non-negative numbers
(define (sum-positives L)
  (cond [(empty? L) 0]
        [else (+ (first L) (sum-positives(rest L)))]))


;; clean-input: List[Number] -> List[Number]
;; Consume: A list of numbers
;; Produce: A list of numbers trimmed at the sentinel and all negative values removed
(define (clean-input L)
  (cond [(or (empty? L) (= (first L) -999)) empty]
        [else (cond [(negative? (first L)) (clean-input (rest L))]
                    [else (append (list (first L)) (clean-input (rest L)))])]))


;;Tests for rainfall
;(check-expect (rainfall (list 1 -2 5 -999 8)) (/ 6 2))
;(check-expect (rainfall (list 1 -2 5 8)) (/ 14 3))
;(check-expect (rainfall empty) empty)
;(check-expect (rainfall (list 1)) 1)

;; Tests for sum-positives
;(check-expect (sum-positives (list 1 5)) 6)
;(check-expect (sum-positives (list 1 5 8)) 14)
;(check-expect (sum-positives empty) 0)
;(check-expect (sum-positives (list 1)) 1)

;; Tests for clean-input
;(check-expect (clean-input (list 1 -2 5 -999 8)) (list 1 5))
;(check-expect (clean-input (list 1 -2 5 8)) (list 1 5 8))
;(check-expect (clean-input empty) empty)
;(check-expect (clean-input (list 1)) (list 1))