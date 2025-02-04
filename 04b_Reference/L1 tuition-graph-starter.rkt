;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |L1 tuition-graph-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; tuition-graph-starter.rkt  (just the problem statements)

; 
; PROBLEM:
; 
; Eva is trying to decide where to go to university. One important factor for her is 
; tuition costs. Eva is a visual thinker, and has taken Systematic Program Design, 
; so she decides to design a program that will help her visualize the costs at 
; different schools. She decides to start simply, knowing she can revise her design
; later.
; 
; The information she has so far is the names of some schools as well as their 
; international student tuition costs. She would like to be able to represent that
; information in bar charts like this one:
; 
; 
;         .
;         
; (A) Design data definitions to represent the information Eva has.
; (B) Design a function that consumes information about schools and their
;     tuition and produces a bar chart.
; (C) Design a function that consumes information about schools and produces
;     the school with the lowest international student tuition.
; 


(require 2htdp/image)
(require 2htdp/universe)

;; Scrolling cat from left to right
;; Begin program by typing "(main <number>)" into terminal

;; =================
;; Constants:
(define FONT-SIZE 24)
(define FONT-COLOR "black")
(define Y-SCALE 1/1000) ;;pixel height every dollar
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")
;(define BACKG (empty-scene WIDTH HEIGHT)) ;;background


;; =================
;; Data definitions:

;; School is (make-school String Natural)
;; interp. name of school, student tuition
(define-struct school (name tuition))

(define S1 (make-school "S1" 101010))
(define S2 (make-school "S2" 500000))
(define S3 (make-school "S3" 250000))

(define (fn-for-school s)
  (... (school name s)
       (school tuition s)
  )
)
;; Template rules used:
;; -compound: (make String Natural)

;; ListofSchools is one of:
;; -empty
;; -(cons School ListofSchool)

(define LOS1 empty)
(define LOS2 (cons S1 empty))
(define LOS3 (cons S1 (cons S2 empty)))
(define LOS4 (cons S1 (cons S2 (cons S3 empty))))

(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; =================
;; Functions:

;;List -> Image
;;produces bar graph of schools from list
(check-expect (chart LOS1) (square 0 "solid" "white"))
(check-expect (chart LOS2) (overlay/align "center" "bottom"
                 (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* 101010 Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* 101010 Y-SCALE) "solid" BAR-COLOR)))
(check-expect (chart LOS3) (beside/align "bottom"
                 (overlay/align "center" "bottom"
                 (rotate 90 (text "S1" FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* 101010 Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* 101010 Y-SCALE) "solid" BAR-COLOR))
                 (overlay/align "center" "bottom"
                 (rotate 90 (text "S2" FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* 500000 Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* 500000 Y-SCALE) "solid" BAR-COLOR))
                                         ))

(define (chart los)
  (cond [(empty? los) (square 0 "solid" "white")]
        [else
         (beside/align "bottom" (make-bar (first los)) (chart (rest los))
          )
        ]
  )
)

;; School -> Image
;; generate bar graph for school passed into function
(define (make-bar s)
  (overlay/align "center" "bottom"
                 (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "solid" BAR-COLOR)))


;;ListofSchool -> School
;;produces cheapest tuition available for school

(define (cheapest los)
  (cond [(empty? (rest los)) (first los)]
        [else
         (if (cheaper? (first los) (cheapest (rest los)))
             (first los)
             (cheapest (rest los))
          )
        ]
   )
)

;;School School-> Boolean
(define (cheaper? s1 s2)
  (< (school-tuition s1) (school-tuition s2))
)

(chart LOS3)
(cheapest LOS3)