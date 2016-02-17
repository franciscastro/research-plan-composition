;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname adding-machine) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; adding-machine: List[Numbers] -> List[Numbers]
; Consume: List of numbers
; Produce: List of sums of each non-empty sublist
; Other: Sublists are separated by 0
;        Ignore all elements after first occurrence of 00
(define (adding-machine L) 
  (build-sum-list (clean-data L) (list) 0))

; build-sum-list: List[Numbers] List[Numbers] Number -> List[Numbers]
; Consume: List of numbers being processed, current list of sums processed, current sum being processed
; Produce: List of sums of each non-empty sublist
(define (build-sum-list L SL CS)
  (cond [(empty? L) (cond [(= CS 0) SL]                   ;; logic: reached end of list, no remaining sum computed (last item was 0)
                          [else (append SL (list CS))])]  ;; logic: reached end of list, append remaining sum computed (last item was not 0)
        [else (cond [(= (first L) 0)                        ;; logic: item is zero,
                     (build-sum-list (rest L)               ;; > recursive call on rest of list,
                                     (append SL (list CS))  ;; > append current-computed-sum to sum-list,
                                     0)]                    ;; > reset current-computed-sum
                    [else (build-sum-list (rest L)                ;; logic: item is not zero, recursive call on rest of list,
                                          SL                      ;; > keep current sum-list,
                                          (+ (first L) CS))])]))  ;; > add item to current-computed-sum

; clean-data: List[Numbers] -> List[Numbers]
; Consume: list of numbers
; Produce: list of numbers with 00 and all numbers after it, removed
(define (clean-data L) 
  (cond [(empty? L) empty]    ;; structure: empty list?
        [(= 1 (length L)) L]  ;; structure: 1 element in list?
        [else (cond [(consecutive-zeros? (first L) (second L)) empty]           ;; logic: consecutive zeros?
                    [else (append (list (first L)) (clean-data (rest L)))])]))  ;; logic: append element to rest of list

; consecutive-zeros?: Number Number -> Boolean
; Consume: Two numbers
; Produce: True if the two numbers are consecutive zeros, false otherwise
(define (consecutive-zeros? N1 N2)
  (and (= N1 0) (= N2 0)))

;; Tests for adding-machine
(check-expect (adding-machine (list 1 2 0 7 0 5 4 1 0 0 6)) (list 3 7 10))
(check-expect (adding-machine (list 00)) ( list 0))
(check-expect (adding-machine (list 0)) (list 0))
(check-expect (adding-machine (list 1)) (list 1))
(check-expect (adding-machine (list)) (list))

;; Tests for clean-data
(check-expect (clean-data empty) empty)
(check-expect (clean-data (list empty)) (list empty))
(check-expect (clean-data (list 1)) ( list 1))
(check-expect (clean-data (list 0)) ( list 0))
(check-expect (clean-data (list 1 2 0 7 0 5 4 1 0 0 6)) (list 1 2 0 7 0 5 4 1))
(check-expect (clean-data (list 1 2 0 0 6)) (list 1 2))
(check-expect (clean-data (list 0 0)) empty)
(check-expect (clean-data (list 0 1 2 0 0 6)) (list 0 1 2))
(check-expect (clean-data (list 1 2 3 4 5 6 7)) (list 1 2 3 4 5 6 7))

;; Tests for consecutive-zeros?
(check-expect (consecutive-zeros? 0 0) true)
(check-expect (consecutive-zeros? 1 0) false)
(check-expect (consecutive-zeros? 0 1) false)
(check-expect (consecutive-zeros? 1 1) false)