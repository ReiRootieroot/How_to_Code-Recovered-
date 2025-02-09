;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |P1 movie-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; movie-starter.rkt

; 
; PROBLEM A:
; 
; Design a data definition to represent a movie, including  
; title, budget, and year released.
; 
; To help you to create some examples, find some interesting movie facts below: 
; "Titanic" - budget: 200000000 released: 1997
; "Avatar" - budget: 237000000 released: 2009
; "The Avengers" - budget: 220000000 released: 2012
; 
; However, feel free to resarch more on your own!
; 


;; Movie is (make-movie String, Natural[0, inf], Natural [1888, inf])
;; interp. (make-movie String, Natural[0, inf], Natural [1888, inf]) is movie title, budget, and year in respective order
;;    - String is movie title
;;    - Natural[0, inf] is budget in dollars (est. millions)
;;    - Natural[1888, inf] is year created. I don't count motion photography, so Horse in Motion doesn't count. sorry.
(define-struct movie (title budget year))

(define M1 (make-movie "Titanic" 200000000 1997))
(define M2 (make-movie "Avatar" 237000000 2009))
(define M3 (make-movie "The Avengers" 220000000 2012))

(define (fn-for-movie m1 m2)
  (...
       ;;Movie 1
       (movie-title m1) ;;String
       (movie-budget m1) ;;Natural[0, inf]
       (movie-year m1) ;;Natural[1888, inf]

       ;;Movie 2
       (movie-title m2) ;;String
       (movie-budget m2) ;;Natural[0, inf]
       (movie-year m2) ;;Natural[1888, inf]
  )
)

; Template rules used:
;;  - compound: 3 fields

; 
; PROBLEM B:
; 
; You have a list of movies you want to watch, but you like to watch your 
; rentals in chronological order. Design a function that consumes two movies 
; and produces the title of the most recently released movie.
; 
; Note that the rule for templating a function that consumes two compound data 
; parameters is for the template to include all the selectors for both 
; parameters.
; 


;; =================
;; Functions:

;;Movie, Movie -> String
;;produce title of the most recently released movie
(check-expect (releasedMovie M1 M2) "Avatar")
(check-expect (releasedMovie M2 M1) "Avatar")

(define (releasedMovie m1 m2)
  (if (> (movie-year m1) (movie-year m2))
      (movie-title m1)
      (movie-title m2)
  )
)

(releasedMovie M3 M1)