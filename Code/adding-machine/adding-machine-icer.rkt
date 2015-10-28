;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname adding-machine-icer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(check-expect (adding-machine1 (list 1 2 0 7 0 5 4 1 0 0 6)) (list 3 7 10))

;; Adding Machine using parse without local
(define (adding-machine1 L)
  (sum-lists (parse1 (truncate L) (list) (list))))

(check-expect (adding-machine2 (list 1 2 0 7 0 5 4 1 0 0 6)) (list 3 7 10))

;; Adding Machine using parse with local
(define (adding-machine2 L)
  (sum-lists (parse2 (truncate L))))

;;------------------------------------------------------------------------------------------------------------
;; HELPER FUNCTIONS
;;------------------------------------------------------------------------------------------------------------

;; Build list of sums
;; LL: list of lists
(define (sum-lists LL)
  (cond [(empty? LL) empty]
        [else (append (list (sum-elements (first LL))) (sum-lists (rest LL)))]))

;; Sum elements in a list
;; L: list of numbers
(define (sum-elements L)
  (cond [(empty? L) 0]
        [else (+ (first L) (sum-elements (rest L)))]))

;; Truncate input list L at 0 0 pattern
;; L: list of numbers
(define (truncate L)
  (cond [(empty? L) empty]
        [(= 1 (length L)) L]
        [else (cond [(and (= 0 (first L)) (= 0 (second L))) empty]
                    [else (append (list (first L)) (truncate (rest L)))])]))

;; Group sublists from a flattened list with 0 delimiter
;; L: list of numbers
;; PSL: processed sublist
;; PLL: processed list of list
(define (parse1 L PSL PLL)
  (cond [(empty? L) PLL]
        [else (cond [(= 0 (first L)) (parse1 (rest L) (list) (append PLL (list PSL)))]
                    [(= 1 (length L)) (append PLL (list (append PSL (list (first L)))))]
                    [else (parse1 (rest L) (append PSL (list (first L))) PLL)])]))

;; Group sublists from a flattened list with 0 delimiter
;; L: list of numbers
;; PSL: processed sublist
;; PLL: processed list of list
(define (parse2 L)
  (local [(define (group-sublists L PSL PLL)
            (cond [(empty? L) PLL]
                  [else (cond [(= 0 (first L)) (group-sublists (rest L) (list) (append PLL (list PSL)))]
                              [(= 1 (length L)) (append PLL (list (append PSL (list (first L)))))]
                              [else (group-sublists (rest L) (append PSL (list (first L))) PLL)])]))]
    (group-sublists L (list) (list))))

;;------------------------------------------------------------------------------------------------------------
;; TEST CASES
;;------------------------------------------------------------------------------------------------------------

;; Tests for truncate function
;(check-expect (truncate (list 1 2 0 7 0 5 4 1 0 0 6)) (list 1 2 0 7 0 5 4 1))
;(check-expect (truncate (list)) empty)
;(check-expect (truncate (list 1 2 0 7)) (list 1 2 0 7))
;(check-expect (truncate (list 1 2 0 7 0)) (list 1 2 0 7 0))

;; Tests for parse without local
;(check-expect (parse1 (list 1 2 0 7 0 5 4 1) (list) (list)) (list (list 1 2) (list 7) (list 5 4 1)))
;(check-expect (parse1 (list) (list) (list)) empty)
;(check-expect (parse1 (list 1 2 0 7) (list) (list)) (list (list 1 2) (list 7)))
;(check-expect (parse1 (list 1 2 0 7 0) (list) (list)) (list (list 1 2) (list 7)))

;; Tests for parse with local
;(check-expect (parse2 (list 1 2 0 7 0 5 4 1)) (list (list 1 2) (list 7) (list 5 4 1)))
;(check-expect (parse2 (list)) empty)
;(check-expect (parse2 (list 1 2 0 7)) (list (list 1 2) (list 7)))
;(check-expect (parse2 (list 1 2 0 7 0)) (list (list 1 2) (list 7)))