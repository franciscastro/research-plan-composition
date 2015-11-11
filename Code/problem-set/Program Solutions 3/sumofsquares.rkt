;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sumofsquares) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Francisco Enrique Vicente G. Castro
;; Last update: 16 September 2014

#|
Sum of Squares

Design a program sumOfSquares that consumes an integer n and produces the sum of the squares of all numbers from 1 through n.
You may assume that n is at least 1.

Example: sumOfSquares(4) yields 30
|#

;; sumofsquares : Number -> Number
;; Consumes an integer n and produces the sum of the squares of all numbers from 1 through n, n is at least 1
( define ( sumofsquares n ) 
   ( cond [ ( = n 1 ) 1 ]
          [ else ( + ( * n n ) ( sumofsquares ( - n 1 ) ) ) ] ) )

;; Function Test
( check-expect ( sumofsquares 4 ) 30 )
( check-expect ( sumofsquares 1 ) 1 )
( check-expect ( sumofsquares 2 ) 5 )
( check-expect ( sumofsquares 3 ) 14 )