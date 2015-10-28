;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname mostfrequent) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Design a program mostFrequent that consumes a list of strings and
;; produces a list of the three words that occur most often in the list.
;; Ex: (mostFrequent ("cock" "balls" "dick" "cum" "fuck" "cum" "cock" "fuck" "fuck"))

(define (mostFrequent L)
  (cond [(empty? L) empty]
        [else (highest-N (sort-data (build-word-data (unique-words L)
                                                     (unique-counts (unique-words L) L)))
                         3)]))

;; DATA TRANSFORMATION
;; ==================================================

;; Data structure to be used for transformation
(define-struct wordnumpair (word count))

;; Input: A list of words: L - list of words
;; Output: A list of the unique words in the input
(define (unique-words L)
  (local [(define (build-unique-list L UL)
            (cond [(empty? L) UL]
                  [else (cond [(not (member? (first L) UL)) (build-unique-list (rest L) (append UL (list (first L))))]
                              [else (build-unique-list (rest L) UL)])]))]
    (build-unique-list L empty)))

;; Input: (1) A list of unique words: UW - unique words
;;        (2) The original list of words: L - list of words
;; Output: A list of the counts of the occurrences of each unique word
;;        [1-to-1 correspondence with the list of unique words from unique-words()]
;; Works with count-word() for counting the word occurrences
(define (unique-counts UW L)
  (cond [(empty? UW) empty]
        [else (cons (count-word (first UW) L) (unique-counts (rest UW) L))]))

;; Input: (1) A word: W - word
;;        (2) The original list of words: L - list of words
;; Output: Count of the word's occurrence in the list
(define (count-word W L)
  (cond [(empty? L) 0]
        [else (cond [(equal? W (first L)) (+ 1 (count-word W (rest L)))]
                    [else (count-word W (rest L))])]))

;; Input: (1) A list of unique words: UW - unique words
;;        (2) A list of counts of the unique words: UC - unique counts
;; Output: A list of structures, where each structure is a combined word-count pair from UW and UC
(define (build-word-data UW UC)
  (cond [(empty? UW) empty]
        [else (cons (make-wordnumpair (first UW) (first UC))
                    (build-word-data (rest UW) (rest UC)))]))

;; ==================================================


;; DATA PROCESSING
;; ==================================================

;; Input: A list of word-count structures: DATA
;; Output: A sorted list of word-count structures in descending order
;; Works with sorter() to insert a structure in the correct location
(define (sort-data DATA)
  (cond [(empty? DATA) empty]
        [else (sorter (first DATA) (sort-data (rest DATA)))]))

;; Input: (1) A single word-count structure: D - single word-count data
;;        (2) A list of word-count structures: LS - word-count structure list
;; Output: A list with D inserted in the correct position
(define (sorter D LS)
  (cond [(empty? LS) (cons D empty)]
        [else (cond [(> (wordnumpair-count D) (wordnumpair-count (first LS))) (cons D LS)]
                    [else (cons (first LS) (sorter D (rest LS)))])]))

;; Input: (1) A sorted (descending) list of word-count structures: SDL - sorted DATA list
;;        (2) A number to denote how many to select from the word-count list: N - number
;; Output: A list of the first N words (3 with highest occurrences)
(define (highest-N SDL N)
  (local [(define (build-highest-list SDL N COUNT)
            (cond [(or (= COUNT N) (empty? SDL)) empty]
                  [else (cons (wordnumpair-word (first SDL)) (build-highest-list (rest SDL) N (+ 1 COUNT)))]))]
    (build-highest-list SDL N 0)))

;; ==================================================


(define words (list "cock" "balls" "dick" "cum" "fuck" "cum" "cock" "fuck" "fuck" "cock"))
;(unique-words words)
;(unique-counts (unique-words words) words)
;(build-word-data (unique-words words) (unique-counts (unique-words words) words))
(define a (build-word-data (unique-words words) (unique-counts (unique-words words) words)))
(sort-data a)
;(define b (sort-data a))
;(highest-N b 3)
(mostFrequent words)
