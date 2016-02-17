;; Francisco Enrique Vicente G. Castro
;; Last update: 01 September 2014

#|
Sum over Table

Assume that we represent tables of numbers as lists of rows, 
where each row is itself a list of numbers. 
The rows may have different lengths.
Design a program sumLargest that consumes a table of numbers and 
produces the sum of the largest item from each row.

Example: 
to run this program on the table shown below, use 
sumLargest([[1,7,5,3],[20],[6,9]]), which yields 36 (7 + 20 + 9)
|#

#lang racket

;; sumlargest : List -> Number
;; Consumes a table of numbers and produces the sum of the largest item from each row
( define ( sumlargest tableofnumbers )
   ( if ( empty? tableofnumbers ) 0                       ; Check if list is empty
    ( + ( apply max ( first tableofnumbers ) )            ; If not, add the largest value in a row...
        ( sumlargest ( rest tableofnumbers ) ) ) ) )      ; ... to rest of the largest values in succeeding rows

;; Test code
;; ( define a ( list ( list 1 7 5 3 ) ( list 20 ) ( list 6 9 ) ) )
;; ( sumlargest a )