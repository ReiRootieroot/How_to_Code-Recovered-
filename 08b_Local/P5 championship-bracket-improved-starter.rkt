;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P5 championship-bracket-improved-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; championship-bracket-improved-starter.rkt 

; 
; Recall the USA Ultimate championship bracket problem from Two One-Of module.
; 
; In this problem, you will be asked to improve a function called ouster using
; local, which is provided at the end of this file.


; The weekend of October 17-20, 2013, USA Ultimate held its annual national
; championships tournament in Frisco, Texas. 
; 
; Here is a diagram of the results:
; 
; 
; .
; 
; (Taken from http://scores.usaultimate.org/scores/#womens/tournament/13774)
; See http://en.wikipedia.org/wiki/Bracket_(tournament) for an explanation of
; tournament brackets.
; 


(define-struct bracket (team-won team-lost br-won br-lost))
;; Bracket is one of:
;; - false
;; - (make-bracket String String Bracket Bracket)
;; interp.  A tournament competition bracket.
;;    false indicates an empty bracket.
;;    (make-bracket t1 t2 br1 br2) means that 
;;    - team t1 beat team t2, and
;;    - br1 represents team t1's bracket leading up to this match.
;;    - br2 represents team t2's bracket leading up to this match.
  
(define B0 false)  ; an empty tournament bracket, 

;; Real bracket examples are named using the bracket letter from the figure.

(define BE                                         ; 1st round match-up:
  (make-bracket "Riot" "Schwa" false false))       ; - Riot defeat Schwa

(define BF                                         ; 1st round match-up:
  (make-bracket "Nemesis" "Ozone" false false))    ; - Nemesis defeat Ozone

(define BG                                         ; 1st round match-up:
  (make-bracket "Scandal" "Phoenix" false false))  ; - Scandal defeat Phoenix

(define BH                                         ; 1st round match-up:
  (make-bracket "Capitals" "Traffic" false false)) ; - Capitals defeat Traffic

(define BK                                         ; 2nd Round match-up:
  (make-bracket "Riot" "Nemesis" BE BF))           ; - Riot defeat Nemesis

(define BL                                         ; 2nd round match-up:
  (make-bracket "Scandal" "Capitals" BG BH))       ; - Scandal defeat Capitals

(define BN                                         ; 3rd round match-up:
  (make-bracket "Scandal" "Riot" BL BK))           ; -  Scandal defeat Riot

#;
(define (fn-for-bracket br)
  (cond [(false? br) (...)]
        [else
         (... (bracket-team-won br)
              (bracket-team-lost br)
              (fn-for-bracket (bracket-br-won br))
              (fn-for-bracket (bracket-br-lost br)))]))
  
  
;; ListOfTeam is one of:
;; - empty
;; - (cons String ListOfTeam)
;; interp. A list of team names
(define T0 empty)  ; no teams
(define T2 (list "Scandal" "Traffic"))

(define (fn-for-lot lot)
  (cond [(empty? lot) (...)]
        [else
         (... (first lot)
              (fn-for-lot (rest lot)))]))

; PROBLEM:
; 
; In a tournament, there may be only one champion, but there can be many 
; winners...and losers. Below is a function that takes a bracket and a team 
; and produces the name of the team that knocked the given team out of the 
; tournament, or false if there's no such team in the bracket (either because 
; the team never lost or the given team was not in the bracket).
; 
; Use the local expression form to improve the function.  Briefly, state one
; justification for using local in this case (there may be more than one).
; 


;; String Bracket -> String or false
;; produce the team that knocked out (i.e. ousted) t in bracket br,              
;; or false if there isn't one.

(check-expect (ouster "Nemesis" false) false)
(check-expect (ouster "Scandal" BN) false)
(check-expect (ouster "Nemesis" BN) "Riot")
(check-expect (ouster "Traffic" BN) "Capitals")

; The function includes the use of generative recursion.
; As such, the callback to needing to search through each individual bracket will become cumbersome.
; It is placed within the inner loop to so it would not be computed if not required.


(define (ouster t br)
  (cond [(false? br) false]
        [else
         (if (string=? t (bracket-team-lost br))
             (bracket-team-won br)
             (local [(define OUSTED-BRACKET-WON (ouster t (bracket-br-won br)))]
               (if (not (false? OUSTED-BRACKET-WON))
                   OUSTED-BRACKET-WON
                   (ouster t (bracket-br-lost br)))
             )
          )
        ]
   )
)
