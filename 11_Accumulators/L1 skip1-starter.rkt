;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |L1 skip1-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; skip1-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a list of elements and produces the list
; consisting of only the 1st, 3rd, 5th and so on elements of its input. 
; 
;    (skip1 (list "a" "b" "c" "d")) should produce (list "a" "c")
; 


;; (listof X) -> (listof X)
;; produce list consisting of 1st, 3rd, 5th, ... etc. elements
;;(define (skip1 lox) empty) ;;stub
(check-expect (skip1 (list 1 2 3 4 5 6)) (list 1 3 5))
(check-expect (skip1 (list "a" "b" "c" "d")) (list "a" "c"))

; ACCUMULATOR TEMPLATE
; 
; (define (skip1 lox0)
;   (local [(define (skip1 lox acc)
;             (cond [(empty? lox) (... acc)]
;                   [else
;                    (... acc
;                         (first lox)
;                         (skip1 (rest lox)
;                                (... acc (first lox))))]))]
;     
;     (skip1 lox0 ...)))
; 
; 1. Template according to structural recursion
; 2. Encapsulate the function in an outer function and local
;   --Make sure the outer function differs in name from the inner function
; 3. Add accumulator parameter to inner function


(define (skip1 lox0)
  ;;acc Natural; i-based position of (first lox) in lox0
  ;;(skip1 (list "a" "b" "c") 1)
  ;;(skip1 (list     "b" "c") 2)
  ;;(skip1 (list         "c") 3)
  (local [(define (skip1 lox acc)
          (cond [(empty? lox) empty]
                [else
                 (if (odd? acc)
                     (cons (first lox) (skip1 (rest lox) (add1 acc)))
                     (skip1 (rest lox) (add1 acc))
                     )
                 ]
           )
          )
         ]
    (skip1 lox0 1)
  )
)