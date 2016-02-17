;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sum-largest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; sum-largest: List[list[numbers]] -> Number
; Consume: List of [list of numbers]
; Produce: Sum of the largest number from each sublist
; Other: No row is empty
(define (sum-largest LL)
  (local [(define (sum-all L)
            (cond [(empty? L) 0]
                   [else (+ (first L) 
                            (sum-all (rest L)))]))]
    (sum-all (build-max-list LL))))


; build-sum-list: List[List[Numbers]] -> List[Numbers]
; Consume: List of [list of numbers]
; Produce: List of numbers where each number is the maximum in the sublists
(define (build-max-list LL)
  (cond [(empty? LL) empty]
        [else (append (list(get-max (first LL))) 
                      (build-max-list (rest LL)))]))

; get-max: List[Numbers] -> Number
; Consume: List of numbers
; Produce: The maximum value in the list
(define (get-max L)
  (local [(define (select-max L N)
            (cond [(empty? L) N]
                  [else (cond [(> (first L) N) (select-max (rest L) (first L))]
                              [else (select-max (rest L) N)])]))]
    (select-max (rest L) (first L))))

;; Tests for sum-largest
(check-expect (sum-largest (list (list 1 7 5 3) (list 20) (list 6 9))) 36)
(check-expect (sum-largest (list (list 1) (list 0) (list -1 -4 -5))) 0)
(check-expect (sum-largest (list (list -1) (list 0 0 0) (list 5 5 11 10 11))) 10)
(check-expect (sum-largest (list (list 9))) 9)

;; Tests for build-max-list
(check-expect (build-max-list (list (list 1 7 5 3) (list 20) (list 6 9)))
              (list 7 20 9))
(check-expect (build-max-list (list (list 1) (list 0) (list -1 -4 -5)))
              (list 1 0 -1))
(check-expect (build-max-list (list (list -1) (list 0 0 0) (list 5 5 11 10 11)))
              (list -1 0 11))

;; Tests for get-max
(check-expect (get-max (list 1 7 5 3)) 7)
(check-expect (get-max (list 20)) 20)
(check-expect (get-max (list 6 9)) 9)
(check-expect (get-max (list 0)) 0)
(check-expect (get-max (list 1 1 1 1)) 1)