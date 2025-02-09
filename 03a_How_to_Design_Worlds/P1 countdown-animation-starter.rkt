;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P1 countdown-animation-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; countdown-animation starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a simple countdown. 
; 
; Your program should display a simple countdown, that starts at ten, and
; decreases by one each clock tick until it reaches zero, and stays there.
; 
; To make your countdown progress at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, 
; (on-tick advance-countdown 1) then big-bang will wait 1 second between 
; calls to advance-countdown.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Once you are finished the simple version of the program, you can improve
; it by reseting the countdown to ten when you press the spacebar.
; 


;; Begins a countdown starting from 10 upon initiation
;; start program with (main) in terminal




;; =================
;; Constants:
(define WIDTH 200)
(define HEIGHT 200)
(define CENTERX (/ WIDTH 2))
(define CENTERY (/ HEIGHT 2))
(define BACKG (empty-scene WIDTH HEIGHT)) ;;background
(define TEXTS 50) ;;Text size
(define TEXTC "black") ;Text color

;; =================
;; Data definitions:
;; Second is Number
;; interp. the tick that countdown countdowns by

(define C10 10) ;;beginning of countdown
(define C1 1) ;;nearly end of countdown
(define C0 0) ;;end of countdown

(define (fn-for-cd c)
  (... c)
)

;; =================
;; Functions:

;; Second -> Second
;; start the world with "(main <number>)"
;; 
(define (main s)
  (big-bang s                 ; Second
            (on-tick   advance-countdown 1)     ; Second -> Second
            (to-draw   display-countdown)   ; Second -> Image
            (on-key    handle-key)  ; Second KeyEvent -> Second
  )
)

;; Second -> Second
;; produce the next numnber in countdown. Stop at 0.

;;(define (advance-countdown s) 10)
(check-expect (advance-countdown 30) C10)
(check-expect (advance-countdown C10) 9)
(check-expect (advance-countdown C1) 0)
(check-expect (advance-countdown 0) 0)

(define (advance-countdown s)
  (cond [(> s 10) C10]
        [(<= s 0) 0]
        [else (- s 1)]
  )
)



;; Second -> Image
;; render the current countdown

;;(define (display-countdown s) BACKG)
(check-expect (display-countdown 9) (place-image (text (number->string 9) TEXTS TEXTC) CENTERX CENTERY BACKG))

(define (display-countdown s)
  (place-image (text (number->string s) TEXTS TEXTC) CENTERX CENTERY BACKG)
)

;; Second KeyEvent -> Second
;; restart countdown back to 10
(check-expect (handle-key 10 " ")  10)
(check-expect (handle-key 8 "a") 8)
(check-expect (handle-key  0 " ")  10)
(check-expect (handle-key  0 "a")  0)

;(define (handle-key c ke) 0) ;stub

(define (handle-key c ke)
  (cond [(key=? ke " ") 10]
        [else c]))