;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname adding-machine1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; adding-machine: List[Number] -> List[Number]
;; Consume: List of Number
;; Produce: List of Number
;; Other: Input is a list of number with single zeros as separators for sublists
;;        Ignore all input after double zeros
(define (adding-machine L)
  (build-sum-list (clean-input L) (list) 0))


;; build-sum-list: List[Number] List[Number] Number -> List[Number]
;; Consume: LiP (List in Process), PL (Processed List), SiP (Sum in Process)
;; Produce: List of the sums of each sub-list
(define (build-sum-list LiP PL SiP)
  (cond [(empty? LiP) (cond [(= SiP 0) PL]
                            [else (append PL (list SiP))])]
        [else (cond [(= 0 (first LiP)) (build-sum-list (rest LiP) (append PL (list SiP)) 0)]
                    [else (build-sum-list (rest LiP) PL (+ SiP (first LiP)))])]))


;; clean-input: List[Number] -> List[Number]
;; Consume: List of numbers
;; Produce: List of numbers with all numbers after 00, including 00, removed
(define (clean-input L)
  (cond [(empty? L) empty]   ; empty L
        [(= 1 (length L)) L] ; single-element L
        [else (cond [(and (= (first L) 0) (= (second L) 0)) empty]
                    [else (append (list (first L)) (clean-input (rest L)))])]))


;; Tests for adding-machine and build-sum-list
;(check-expect (adding-machine (list 1 2 0 7 0 5 4 1 0 0 6)) (list 3 7 10))
;(check-expect (adding-machine (list 1 2 0 7 0 5 4 1 0 )) (list 3 7 10))
;(check-expect (adding-machine empty) empty)
;(check-expect (adding-machine (list 0 0)) empty)
;(check-expect (adding-machine (list 1)) (list 1))
;(check-expect (adding-machine (list 1 2)) (list 3))
;(check-expect (adding-machine (list 0)) (list 0))
;(check-expect (adding-machine (list 1 2 3 4 5 6 7)) (list 28))

;; Tests for clean-input
;(check-expect (clean-input (list 1 2 0 7 0 5 4 1 0 0 6)) (list 1 2 0 7 0 5 4 1))
;(check-expect (clean-input empty) empty)
;(check-expect (clean-input (list 0 0)) empty)
;(check-expect (clean-input (list 1)) (list 1))
;(check-expect (clean-input (list 1 2)) (list 1 2))
;(check-expect (clean-input (list 0)) (list 0))
;(check-expect (clean-input (list 0 1 2)) (list 0 1 2))