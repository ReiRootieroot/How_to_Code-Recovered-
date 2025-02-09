;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P1 wide-only-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; wide-only-starter.rkt

; 
; PROBLEM:
; 
; Use the built in version of filter to design a function called wide-only 
; that consumes a list of images and produces a list containing only those 
; images that are wider than they are tall.
; 


(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 30 20 "solid" "yellow"))
(define I3 (rectangle 40 50 "solid" "green"))
(define I4 (rectangle 60 50 "solid" "blue"))
(define I5 (rectangle 90 90 "solid" "orange"))

;; Image -> Boolean
;; return true if image is wider than taller
;;(define (wide? i) true);;stub
(check-expect (wide? I1) false)
(check-expect (wide? I2) true)
(check-expect (wide? I3) false)
(check-expect (wide? I4) true)
(check-expect (wide? I5) false)

(define (wide? i) (> (image-width i) (image-height i)))

;; (listof Image) -> (listof Image)
;; produce list of images that only contains images wider than tall
;;(define (wide-only loi) empty) ;;stub
(check-expect (wide-only empty) empty)
(check-expect (wide-only (list I1)) empty)
(check-expect (wide-only (list I1 I2)) (list I2))
(check-expect (wide-only (list I1 I3)) empty)
(check-expect (wide-only (list I2 I4)) (list I2 I4))
(check-expect (wide-only (list I1 I2 I3 I4 I5)) (list I2 I4))

(define (wide-only loi) (filter wide? loi))