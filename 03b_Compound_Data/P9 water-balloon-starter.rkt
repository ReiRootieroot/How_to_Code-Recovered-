;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P9 water-balloon-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;; water-balloon-starter.rkt

; PROBLEM:
; 
; In this problem, we will design an animation of throwing a water balloon.  
; When the program starts the water balloon should appear on the left side 
; of the screen, half-way up.  Since the balloon was thrown, it should 
; fly across the screen, rotating in a clockwise fashion. Pressing the 
; space key should cause the program to start over with the water balloon
; back at the left side of the screen. 
; 
; NOTE: Please include your domain analysis at the top in a comment box. 
; 
; Use the following images to assist you with your domain analysis:
; 
; 
; 1)
; 2).
; .
; 3)
; .
; 4)
; 
; .
;     
; 
; Here is an image of the water balloon:
; (define WATER-BALLOON.)
; 
; 
; 
; NOTE: The rotate function wants an angle in degrees as its first 
; argument. By that it means Number[0, 360). As time goes by your balloon 
; may end up spinning more than once, for example, you may get to a point 
; where it has spun 362 degrees, which rotate won't accept. 
; 
; The solution to that is to use the modulo function as follows:
; 
; (rotate (modulo ... 360) (text "hello" 30 "black"))
; 
; where ... should be replaced by the number of degrees to rotate.
; 
; NOTE: It is possible to design this program with simple atomic data, 
; but we would like you to use compound data.


;; Start program with typing "(main (make-slambda 50 50 0 false))" into terminal
;; NOTE: IT MUST BE FALSE FOR PROGRAM TO START CORRECTLY. 

;; =================
;; Constants:
(define WATER-BALLOON.)
(define SPEED 10) ;;speed of ballon, pixels per tick
(define HEIGHT 400) ;;window height
(define LENGTH (* HEIGHT 2)) ;;window length
(define YCOOR (/ HEIGHT 2)) ;;y-coordinate of balloon
(define BACKG (empty-scene LENGTH HEIGHT)) ;;background

;; =================
;; Data definitions:

;; Balloon is (make-balloon Natural[0, LENGTH], Natural[0,360), Natural[-inf, inf], Boolean)
;; interp. (make-balloon Natural[0, LENGTH], Natural[0,360), Natural[-inf, inf], Boolean) is spinning water balloon
;;    -Natural[0, LENGTH] is x-coordinate of balloon
;;    -Natural[0,360) is rotation from normal in degrees
;;    -Natural[-inf, inf] is speed, pixels per tick
;;    -Boolean is status of program when first started. False for calling main, True for currently running
(define-struct balloon (xcoor rotate speed status))

(define (fn-for-balloon b)
  (... (balloon-xcoor b)
       (balloon-rotate b)
       (balloon-speed b)
       (balloon-status b)
  )
)

;;Templates used:
;;-compound: 4 fields

;; =================
;; Functions:

;; Balloon -> Balloon
;; main function

(define (main c)
  (big-bang c                        ; Balloon
            (on-tick   advanceBalloon)     ; Balloon -> Balloon
            (to-draw   render)   ; Balloon -> Image
            (on-key  resetBalloon) ; Balloon KeyEvent -> Balloon
   )
)

;; Balloon -> Balloon
;; Generate next frame of balloon movement
;;(define (advanceBalloon b) b) ;;stub
(check-expect (advanceBalloon (make-balloon 40 40 4 false)) (make-balloon -30 0 SPEED true))
(check-expect (advanceBalloon (make-balloon 40 50 4 true)) (make-balloon (+ 40 4) (- 50 4) SPEED true))

(define (advanceBalloon b)
  (cond[(false? (balloon-status b))
         (make-balloon -30 0 SPEED true)
       ]
       [else
         (make-balloon (+ (balloon-xcoor b) (balloon-speed b)) (- (balloon-rotate b) (balloon-speed b)) SPEED true)
       ]

  )
)

;; Balloon -> Image
;; render current state of Balloon
;;(define (render b) BACKG) ;;stub

(define (render b)
  (if(<= (balloon-xcoor b) (+ LENGTH 20))
     (place-image (rotate(modulo (balloon-rotate b) 360) WATER-BALLOON) (balloon-xcoor b) YCOOR BACKG)
     (place-image (above (text "Press space" 24 "black") (text "to reset" 24 "black")) (- LENGTH 80) YCOOR BACKG)
  )
)

;; Balloon KeyEvent -> Balloon
;; reset Balloon to default state
;;(define (resetBalloon b ke) b) ;;stub
(check-expect (resetBalloon (make-balloon 50 40 SPEED true) " ") (make-balloon -30 0 SPEED true))
(check-expect (resetBalloon (make-balloon 50 40 SPEED true) "a") (make-balloon 50 40 SPEED true))

(define (resetBalloon b ke)
  (cond [(key=? ke " ") (make-balloon -30 0 SPEED true)]
        [else b]
  )
)