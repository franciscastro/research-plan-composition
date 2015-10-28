;; Francisco Enrique Vicente G. Castro
;; Last update: 01 September 2014

#|
Rainfall

Design a program called rainfall that consumes a list of real numbers representing daily rainfall readings.
The list may contain the number -999 indicating the end of the data of interest.
Produce the average of the non-negative values in the list up to the first -999 (if it shows up).
There may be negative numbers other than -999 in the list (representing faulty readings).

Example: rainfall([1, -2, 5, -999, 8]) yields 3
|#

#lang racket

;; is-sentinel : Number -> Boolean
;; Consumes a number and produces #t if number = 0, #f otherwise
( define ( is-sentinel? number )
  ( if ( = number -999) #t #f ) )

;; sumpositives : List -> Number
;; Consumes a list of numbers and produces the sum of the positive values, stops at the sentinel
( define ( sumpositives readings )
  ( cond
     [ ( empty? readings ) 0 ]                                                      ; Check if list is empty
     [ ( is-sentinel? ( first readings ) ) 0 ]                                      ; Check if sentinel has been reached
     [ ( negative? ( first readings ) ) ( sumpositives ( rest readings ) ) ]        ; Skip negative readings
     [ else ( + ( first readings ) ( sumpositives ( rest readings ) ) ) ] ) )       ; Add elements

;; countpositives : List -> Number
;; Consumes a list of numbers and produces the count of the positive values, stops at the sentinel
( define ( countpositives readings )
  ( cond
     [ ( empty? readings ) 0 ]                                                      ; Check if list is empty
     [ ( is-sentinel? ( first readings ) ) 0 ]                                      ; Check if sentinel has been reached
     [ ( negative? ( first readings ) ) ( countpositives ( rest readings ) ) ]      ; Skip negative readings
     [ else ( + 1 ( countpositives ( rest readings ) ) ) ] ) )                      ; Add to valid reading count

;; rainfall : List -> Number
;; Consumes a list of numbers and produces the average of the non-negative values in the list up to the sentinel
( define ( rainfall readings ) 
   ( if ( > ( countpositives readings ) 0 )                                         ; Check if count of positive readings is > 0
        ( / ( sumpositives readings ) ( countpositives readings ) )                 ; Get average of valid readings
        0 ) )                                                                       ; Else, just return zero

;; Test code
;; ( define a ( list 1 -2 5 -999 8 ) )
;; ( rainfall a )