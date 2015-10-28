;; Francisco Enrique Vicente G. Castro
;; Last update: 01 September 2014

#|
Sum of Squares

Design a program sumOfSquares that consumes an integer n and produces the sum of the squares of all numbers from 1 through n.
You may assume that n is at least 1.

Example: sumOfSquares(4) yields 30
|#

#lang racket

;; sumofsquares : Number -> Number
;; Consumes an integer n and produces the sum of the squares of all numbers from 1 through n, n is at least 1
( define ( sumofsquares n ) 
   ( cond 
      [ ( = n 1 ) 1 ]
      [ else ( + ( * n n ) ( sumofsquares ( - n 1 ) ) ) ] ) )

;; Test code
;; ( sumofsquares 4 )