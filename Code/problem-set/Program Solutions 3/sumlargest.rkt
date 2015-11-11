;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sumlargest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Francisco Enrique Vicente G. Castro
;; Last update: 16 September 2014

#|
Sum over Table

Assume that we represent tables of numbers as lists of rows, where each row is itself a list of numbers. 
The rows may have different lengths.
Design a program sumLargest that consumes a table of numbers and produces the sum of the largest item from each row.

Example: 
to run this program on the table shown below, use 
sumLargest([[1,7,5,3],[20],[6,9]]), which yields 36 (7 + 20 + 9)
|# 

;; get-max: List -> Number
;; Consumes a non-empty list of numbers and produces the largest number in the list
( define ( get-max list-of-numbers ) 
   ( if ( = ( length list-of-numbers ) 1 ) 
        ( first list-of-numbers ) 
        ( if ( > ( first list-of-numbers ) ( get-max ( rest list-of-numbers ) ) ) 
             ( first list-of-numbers )              
             ( get-max ( rest list-of-numbers ) ) ) ) )

;; sumlargest: List -> Number
;; Consumes a table of numbers and produces the sum of the largest item from each row
( define ( sumlargest tableofnumbers )
   ( if ( empty? tableofnumbers ) 
        0
        ( + ( get-max ( first tableofnumbers ) ) ( sumlargest ( rest tableofnumbers ) ) ) ) )

;; Function test
( define LIST1 ( cons 1 ( cons 7 ( cons 5 ( cons 3 empty ) ) ) ) )
( define LIST2 ( cons 20 empty ) )
( define LIST3 ( cons 6 ( cons 9 empty ) ) )
( define INPUTLIST ( cons LIST1 ( cons LIST2 ( cons LIST3 empty ) ) ) )
( check-expect ( sumlargest INPUTLIST ) 36 )