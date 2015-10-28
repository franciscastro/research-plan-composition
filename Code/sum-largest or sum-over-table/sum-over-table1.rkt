;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sum-over-table1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define (sum-largest L)
  (local [(define (sum-values L)
            (cond [(empty? L) 0]
                  [else (+ (first L) (sum-values (rest L)))]))]
    (sum-values (build-max-list L))))


;; build-max-list: List[List[Number]] -> List[Number]
;; Consume: A list of [list of numbers]
;; Produce: A list of the largest numbers in each sublist
(define (build-max-list L)
  (cond [(empty? L) empty]
        [else (append (list (get-max (first L))) (build-max-list (rest L)))]))


;; get-max: List[Number] Number -> Number
;; Consume: A list of numbers
;; Produce: The maximum/largest number in the list
(define (get-max L)
  (local [(define (select-max L N)
            (cond [(empty? L) N]
                  [else (cond [(> (first L) N) (select-max (rest L) (first L))]
                              [else (select-max (rest L) N)])]))]
    (select-max (rest L) (first L))))

;; Tests for sum-largest
;(check-expect (sum-largest (list (list 1 7 5 3) (list 20) (list 6 9) ) ) 36)
;(check-expect (sum-largest (list (list 1) (list 0) (list -1 -4 -5))) 0)
;(check-expect (sum-largest (list (list -1) (list 0 0 0) (list 5 5 11 10 11))) 10)
;(check-expect (sum-largest (list (list 9))) 9)

;; Tests for build-max-list
;(check-expect (build-max-list (list (list 1 7 5 3) (list 20) (list 6 9))) (list 7 20 9))
;(check-expect (build-max-list (list (list 20) (list 6 9))) (list 20 9))
;(check-expect (build-max-list (list (list 1 7 5 3))) (list 7))
;(check-expect (build-max-list (list (list -1 0 -2))) (list 0))

;; Tests for get-max
;(check-expect (get-max (list 1 7 5 3)) 7)
;(check-expect (get-max (list 20)) 20)
;(check-expect (get-max (list 6 9)) 9)
;(check-expect (get-max (list -1 0 -2)) 0)