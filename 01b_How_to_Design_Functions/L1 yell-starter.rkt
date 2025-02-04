;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |L1 yell-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; pluralize-stubs-starter.rkt

; PROBLEM:
;  
; You are working on designing a function and have completed your signature and purpose. 
; 
; Write three stubs with different bodies that are consistent with the signature and purpose below.
; Put the three stubs in a comment box.
; 
; ;; String -> String
; ;; pluralizes str by appending "s" to the end 
; 


;; String -> String
;; pluralizes str by appending "s" to the end 

(check-expect (plural "Roxenmouth") "Roxenmouths") ;;first name is "Glo". It does not stand for Gloria.
(check-expect (plural "Baustam") "Baustams") ;;first name is "Richard".

; (define (plural s) string) ;;stub
; (define (plural s) "a") ;;stub
; (define (plural s) "") ;;stub
; 
; (define (plural s) ;;template
;   (... s)
; )


(define (plural s)
  (string-append s "s")
)

(plural "Ectplooding") ;;first name is Imogen, but goes by "Imo"