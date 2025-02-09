;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design a World Program with Compound Data. You can be as creative as you like, but keep it simple.
; Above all, follow the recipes! You must also stay within the scope of the first part of the course.
; Do not use language features we have not seen in the videos. 
; 
; If you need inspiration, you can choose to create a program that allows you to click on a spot on
; the screen tocreate a flower, which then grows over time. If you click again the first flower is
; replaced by a new one at the new position.
; 
; You should do all your design work in DrRacket.
; Following the step-by-step recipe in DrRacket will help you be sure that you have a quality solution.


;; Start program with typing "(main (make-slambda 50 50 0 false))" into terminal
;; NOTE: IT MUST BE FALSE FOR PROGRAM TO START CORRECTLY. 

(require 2htdp/image)
(require 2htdp/universe)

;; =================
;; Constants:
(define FLOWER .) ;; image
(define WINDOWLENGTH 400) ;;square display window
(define BACKG (empty-scene WINDOWLENGTH WINDOWLENGTH)) ;;background
(define SPEED 0.1) ;;if quick rotation and size growth is desired
(define MAX 2) ;;max size flower can grow to

;; =================
;; Data definitions:

;; Flower is (make-flower Natural[0, WINDOWLENGTH], Natural[0, WINDOWLENGTH], Natural[0, MAX])
;; interp. (make-balloon Natural[0, WINDOWLENGTH] Natural[0,360], Boolean) is flower growing
;;    -Natural[0, WINDOWLENGTH] is x-coordinate of flower
;;    -Natural[0, WINDOWLENGTH] is y-coordinate of flower
;;    -Natural[0, MAX] is icon size, determined by side-length
(define-struct flower (x y size))

(define (fn-for-flower f)
  (... (flower-x f)
       (flower-y f)
       (flower-scale f)
  )
)

;;Templates used:
;;-compound: 2 fields

;; =================
;; Functions:

;; Flower -> Flower
;; main function
(define (main c)
  (big-bang c                        ; Flower
            (on-tick   growFlower)   ; Flower -> Flower
            (to-draw   render)   ; Flower -> Image
            (on-mouse  mouseCoor) ; Flower MouseEvent -> Flower
   )
)

;;Flower -> Flower
;;grow flower
;;(define (growFlower f) f) ;;stub
(check-expect (growFlower (make-flower 40 30 1)) (make-flower 40 30 (+ 1 SPEED)))
(check-expect (growFlower (make-flower 40 30 MAX)) (make-flower 40 30 MAX))

(define (growFlower f)
  (cond[(>= (flower-size f) MAX) (make-flower (flower-x f) (flower-y f) MAX)]
       [else (make-flower (flower-x f) (flower-y f) (+ (flower-size f) SPEED))]
  )
)


;;Flower -> Image
;;render flower
;;(define (render f) BACKG) ;;stub
(define (render f)
  (place-image (scale (flower-size f) FLOWER) (flower-x f) (flower-y f) BACKG)
)

;;Flower MouseEvent -> Flower
;;begin growing flower in new position
;;(define (mouseCoor f ke) f) ;;stub
(check-expect (mouseCoor (make-flower 30 40 9) 50 60 "move") (make-flower 30 40 9))
(check-expect (mouseCoor (make-flower 30 40 9) 50 60 "button-down") (make-flower 50 60 0.1))

(define (mouseCoor f xx yy ke)
  (cond [(mouse=? ke "button-down") (make-flower xx yy 0.1)]
        [else f]
  )
)
