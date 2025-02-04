;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P3 strictly-decreasing-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; strictly-decreasing-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a list of numbers and produces true if the 
; numbers in lon are strictly decreasing. You may assume that the list has at 
; least two elements.
; 


(check-expect (decreasing-list (list 5 4 3)) true)
(check-expect (decreasing-list (list 5 3 4)) false)
(check-expect (decreasing-list (list 4 5 3)) false)
(check-expect (decreasing-list (list 1 2 3 4 5)) false)
(check-expect (decreasing-list (list 5 4 3 2 1)) true)

(define (decreasing-list lox0)
  (local [(define LENGTH (length lox0))
          (define (decreasing-list lox acc)
            (cond [(empty? lox) true]
                  [else 
                   (if (equal? acc 1)
                       true
                       (if (> (first lox) (second lox))
                           (decreasing-list (rest lox) (sub1 acc))
                           false
                       )
                     )
                    ]
               )
           )
         ]

    (decreasing-list lox0 LENGTH)))