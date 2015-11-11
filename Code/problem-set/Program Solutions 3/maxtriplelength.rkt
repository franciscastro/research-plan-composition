;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname maxtriplelength) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Francisco Enrique Vicente G. Castro
;; Last update: 26 September 2014

#|
Length of Triples

Design a program called maxTripleLength that consumes a list of strings and 
produces the length of the longest concatenation of three consecutive elements.
Assume the input contains at least three strings.

Example: 
maxTripleLength([“a”, “bb”, “c”, “dd”]) yields 5 (from “bb”, “c”, and “dd”)
|#

;; build-string-from-list : List-of-Strings -> Number
;; Consume: a list of strings
;; Produce: a string which is a concatenation of the elements of the list
( define ( build-string-from-list list-of-strings )
   ( cond [ ( empty? list-of-strings ) "" ]
          [ ( cons? list-of-strings ) ( string-append ( first list-of-strings ) ( build-string-from-list ( rest list-of-strings ) ) ) ] ) )

;; build-list-of-three : Number List-of-Strings -> List-of-Strings
;; Consume: a number which is the size of the original list passed, a list of strings (reduced in size later)
;; Produce: a list of strings, the size of the list is 3
( define ( build-list-of-three original-list-size list-of-strings )
   ( cond [ ( empty? list-of-strings ) empty ]
          [ ( cons? list-of-strings ) ( if ( = ( - original-list-size ( length list-of-strings ) ) 3 ) 
                                           empty 
                                           ( append ( list ( first list-of-strings ) ) ( build-list-of-three original-list-size ( rest list-of-strings ) ) ) ) ] ) )

;; maxtriplelength : List-of-Strings -> Number
;; Consume: a list of strings 
;; Produce: the length of the longest concatenation of three consecutive elements
( define ( maxtriplelength list-of-strings )
   ( cond [ ( empty? list-of-strings ) 0 ]
          [ ( cons? list-of-strings ) 
            ( if ( > ( string-length ( build-string-from-list ( build-list-of-three ( length list-of-strings ) list-of-strings ) ) ) ( maxtriplelength ( rest list-of-strings ) ) ) 
                 ( string-length ( build-string-from-list ( build-list-of-three ( length list-of-strings ) list-of-strings ) ) )
                 ( maxtriplelength ( rest list-of-strings ) ) ) ] ) )

;; Function Test
( define STRINGLIST (list "a" "bb" "c" "dd" ) )
( define STRINGLIST1 (list "a" "bb" "c" "dd" "e" "f" "gg" "hh" "iii" ) )
;; ( check-expect ( maxtriplelength STRINGLIST ) 5 )
;; ( check-expect ( build-list-of-three ( length STRINGLIST ) STRINGLIST ) ( list "a" "bb" "c" ) )
( maxtriplelength STRINGLIST1 )