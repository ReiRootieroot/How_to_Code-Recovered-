;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |P5 championship-bracket-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; championship-bracket-starter.rkt 

; The weekend of October 17-20, 2013, USA Ultimate held its annual national
; championships tournament in Frisco, Texas.  In this problem, you will
; represent and operate on information about the results of the women's 
; competition. Here is a diagram of the results:
; 
; 
; .
; 
; (Taken from http://scores.usaultimate.org/scores/#womens/tournament/13774)
; See http://en.wikipedia.org/wiki/Bracket_(tournament) for an explanation of
; tournament brackets.
; 


; Here is a simple data definition for representing a completed game play
; bracket. For simplicity, it does not represent the scores of the games:
; it only includes the teams, their match-ups, and who won (in green) and
; lost (in white).
; 
; To make sure you understand this data definition, we recommend that you
; copy the types comment and template into their own file, print it out,
; and draw the proper reference arrows.
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

; PROBLEM 1:
; We have intentionally left out definitions for 3 of the brackets that make up
; bracket BN. Give definitions for those 3 brackets below. If you run the file
; you'll see which definitions are missing.
; 


;; Real bracket examples are named using the bracket letter from the figure.

(define BE                                         ; 1st round match-up:
  (make-bracket "Riot" "Schwa" false false))       ; - Riot defeat Schwa

(define BF                                         ; 1st round match-up:
  (make-bracket "Nemesis" "Ozone" false false))    ; - Nemesis defeat Ozone

;;NEW DEFINITIONS ADDED AS PER PROBLEM 1 BELOW
(define BG                                         ; 1st round match-up:
  (make-bracket "Scandal" "Phoenix" false false))  ; - Scandal defeats Phoenix

;;NEW DEFINITIONS ADDED AS PER PROBLEM 1 BELOW
(define BH                                         ; 1st round match-up:
  (make-bracket "Capitals" "Traffic" false false)) ; - Capital defeats Traffic

;;NEW DEFINITIONS ADDED AS PER PROBLEM 1 BELOW
(define BK                                         ; 2nd round match-up:
  (make-bracket "Riot" "Nemesis" BE BF))           ; - Riot defeats Nemesis

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


; SIDE NOTE: we use false to represent an empty bracket so that you cannot
; confuse an empty bracket with an empty list of teams, which is represented
; using empty.



; PROBLEM 2:
; 
; Once a tournament is over, it can be hard to remember even some of the teams
; that your favorite team defeated and the order in which your team played them.
; 
; Design a function that takes a bracket and a list of teams and checks whether 
; or not the winner of the bracket beat those teams in reverse order on the way to 
; winning the current round. Not all of the teams that the victor played need to
; be listed, but the victor must have played the teams listed, and those teams must
; be listed in order from the most recent (latest round) win to least recent win 
; (earliest round of tournament play).
; 
; For instance, if we just consider Fury's semifinal bracket, then we know that
; Fury beat Showdown in the semifinals and beat Nova in the first round, so
; (list "Showdown" "Nova") is a good list of ordered wins for the semifinals,
; and so is just (list "Showdown").  (list "Traffic" "Nova") is not a good list
; because Fury didn't play Traffic, and (list "Nova" "Brute Squad") is not good
; because the order of wins is wrong.
; 
; You must include a properly formed cross-product of types comment table in your
; solution.  You must render it as text in a comment box. It should come after
; the purpose.  You may find it helpful to draw your cross-product on paper for
; your design and then use a tool like http://www.asciiflow.com/#Draw to help you
; render it.  As part of the simplification, number each subclass that produces
; different answers.  For each cell in the cross-product table, label them with
; the appropriate subclass number. In your final function, number each case of
; your cond with a comment to show which subclass it corresponds to in the table.
; 


;; Bracket ListofTeams -> Boolean
;; Check if order of given team list lot matches the same team order winner of bracket b won over
;; Not all losing teams do not need to present, just the order is correct
;; Return true if order is correct, false otherwise
;;(define (bracket-order b lot) false) ;;stub

(check-expect (bracket-order BE empty) false)
(check-expect (bracket-order BE (list "Schwa")) true)
(check-expect (bracket-order BE (list "Riot")) false)
(check-expect (bracket-order BK (list "Nemesis")) true)
(check-expect (bracket-order BK (list "Schwa")) true)
(check-expect (bracket-order BK (list "Nemesis" "Schwa")) true)
(check-expect (bracket-order BK (list "Schwa" "Nemesis")) false)

(define (bracket-order b lot)
  (cond [(empty? lot) false]
        [else
         (correct-order? (make-lose-list b) lot)
        ]
   )
)

;; Bracket -> ListofTeams
;; create list of losing teams based on bracket b passed to function, determined by winner of bracket given, ordered by most recent losing team
;; e.g. "Riot" is the winner of the bracket given, so the teams that lost to "Riot" are included in the list
;;(define (make-lose-list br) empty) ;;stub
(check-expect (make-lose-list B0) empty)
(check-expect (make-lose-list BE) (list "Schwa"))
(check-expect (make-lose-list BF) (list "Ozone"))
(check-expect (make-lose-list BK) (list "Nemesis" "Schwa"))
(check-expect (make-lose-list BL) (list "Capitals" "Phoenix"))
(check-expect (make-lose-list BN) (list "Riot" "Capitals" "Phoenix"))

(define (make-lose-list br)
  (cond [(false? br) empty]
        [else
         (cons (bracket-team-lost br) (make-lose-list (bracket-br-won br)))
        ]
  )
)

;; ListofTeams ListofTeams -> Boolean
;; compare losing team list generated from bracket blot to inputted team list ilot
;; return true if order is correct, false otherwise
;;(define (correct-order? blot ilot) false) ;;stub
(check-expect (correct-order? empty (list "Schwa")) false)
(check-expect (correct-order? (list "Schwa") (list "Schwa")) true)
(check-expect (correct-order? (list "Schwa") (list "Riot")) false)
(check-expect (correct-order? (list "Nemesis" "Schwa") (list "Nemesis" "Schwa")) true)
(check-expect (correct-order? (list "Nemesis" "Schwa") (list "Schwa" "Nemesis")) false)
(check-expect (correct-order? (list "Nemesis" "Riot" "Schwa") (list "Nemesis" "Schwa")) true)
(check-expect (correct-order? (list "Nemesis" "Riot" "Schwa") (list "Riot" "Schwa")) true)
(check-expect (correct-order? (list "Nemesis" "Riot" "Schwa") (list "Nemesis" "Riot")) true)

(define (correct-order? blot ilot)
  (cond [(empty? ilot) true]
        [(empty? blot) false]
        [else
         (if (equal? (first blot) (first ilot))
             (correct-order? (rest blot) (rest ilot))
             (correct-order? (rest blot) ilot)
         )
        ]
  )
)

(bracket-order BN (list "Riot" "Capitals" "Phoenix"))
(bracket-order BN (list "Riot" "Capitals"))
(bracket-order BN (list "Riot" "Phoenix"))
(bracket-order BN (list "Capitals" "Phoenix"))
(bracket-order BN (list "Phoenix" "Riot"))