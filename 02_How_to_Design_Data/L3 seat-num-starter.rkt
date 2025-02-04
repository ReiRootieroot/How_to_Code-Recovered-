;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |L3 seat-num-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; seat-num-starter.rkt

; 
; PROBLEM:
; 
; Imagine that you are designing a program to manage ticket sales for a
; theatre. (Also imagine that the theatre is perfectly rectangular in shape!) 
; 
; Design a data definition to represent a seat number in a row, where each 
; row has 32 seats. (Just the seat number, not the row number.)
;  


;;seatNo is Interval[0,32]
;;interp. seatNo is seat number in a theatre

(define S1 1) ;;start
(define S16 16) ;;mid
(define S32 32) ;;end

(define (fn-for-seat-no sn)
  (... sn)
)

;;Templates used:
;;  - atomic non-distinct: Integer[1, 32]