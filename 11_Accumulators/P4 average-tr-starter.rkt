;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P4 average-tr-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; average-starter.rkt

; 
; PROBLEM:
; 
; Design a function called average that consumes (listof Number) and produces the
; average of the numbers in the list.
; 

(check-expect (average (list 1 2 3)) 2)
(check-expect (average (list 2 3 4)) 3)
(check-expect (average (list 1 2 3 4 5)) 3)
              

(define (average lox0)
  (local [(define LENGTH (length lox0))
          (define (average lox acc)
            (cond [(empty? lox) (/ acc LENGTH)]
                  [else
                   (average (rest lox) (+ acc (first lox)))
                  ]
             )
          )
         ]

    (average lox0 0)))