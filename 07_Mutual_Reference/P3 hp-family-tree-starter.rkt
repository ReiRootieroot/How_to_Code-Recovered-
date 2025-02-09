;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |P3 hp-family-tree-starter|) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;; hp-family-tree-starter.rkt

; In this problem set you will represent information about descendant family 
; trees from Harry Potter and design functions that operate on those trees.
; 
; To make your task much easier we suggest two things:
;   - you only need a DESCENDANT family tree
;   - read through this entire problem set carefully to see what information 
;     the functions below are going to need. Design your data definitions to
;     only represent that information.
;   - you can find all the information you need by looking at the individual 
;     character pages like the one we point you to for Arthur Weasley.
; 


; PROBLEM 1:
; 
; Design a data definition that represents a family tree from the Harry Potter 
; wiki, which contains all necessary information for the other problems.  You 
; will use this data definition throughout the rest of the homework.
; 


;; Data definitions:

(define-struct person (name patronus wand kids))

;; Person is (make-person String String String ListOfPerson)
;; interp. A person, with first name, age and their children
(define LILY (make-person "Lily" "N/A" "N/A" empty))
(define ALBUS (make-person "Albus" "N/A" "Cherry" empty))
(define JAMES (make-person "James" "N/A" "N/A" empty))
(define VICTORIE (make-person "Victorie" "N/A" "N/A" empty))
(define WILLIAM (make-person "William" "N/A" "Wood and Core" (list VICTORIE)))
(define CHARLES (make-person "Charles" "N/A" "Ash" empty))
(define PERCY (make-person "Percy" "N/A" "Wood and Core" empty))
(define FRED (make-person "Fred" "Magpie" "Wood and Core" empty))
(define GEORGE (make-person "George" "Magpie" "Wood and Core" empty))
(define RONALD (make-person "Ronald" "Dog" "Willow" empty))
(define GINERVA (make-person "Ginerva" "Horse" "Yew" (list LILY ALBUS JAMES)))


(define (fn-for-person p)
  (... (person-name p)
       (person-patronus p)
       (person-wand p)
       (fn-for-lop (person-kids p))
  )
)

;; ListOfPerson is one of:
;;  - empty
;;  - (cons Person ListOfPerson)
;; interp. a list of persons

(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-person (first lop))
              (fn-for-lop (rest lop)))]))


;; ListofPair is one of:
;; - empty
;; - (cons (cons String String) ListofPair)
;; interp. pair list of names and their respective patronus
(define LOP1 empty)
(define LOP2 (list (list "William" "N/A") (list "Victorie" "N/A")))

(define (fn-for-lopair lop)
  (cond [(empty? lop) (...)]
        [else
         (... (first (first lop))
              (fn-for-lopair (rest lop)))]))

;; ListofString is one of:
;; - empty
;; - (cons String ListofString)
;; interp. list of string
(define LOS1 empty)
(define LOS2 (list "a" "b"))

(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first lop)
              (fn-for-los (rest los)))]))

; PROBLEM 2: 
; 
; Define a constant named ARTHUR that represents the descendant family tree for 
; Arthur Weasley. You can find all the infomation you need by starting 
; at: http://harrypotter.wikia.com/wiki/Arthur_Weasley.
; 
; You must include all of Arthur's children and these grandchildren: Lily, 
; Victoire, Albus, James.
; 
; 
; Note that on the Potter wiki you will find a lot of information. But for some 
; people some of the information may be missing. Enter that information with a 
; special value of "" (the empty string) meaning it is not present. Don't forget
; this special value when writing your interp.
; 


(define ARTHUR (make-person "Arthur" "Weasal" "Wood and Core" (list WILLIAM CHARLES PERCY FRED GEORGE RONALD GINERVA)))

; PROBLEM 3:
; 
; Design a function that produces a pair list (i.e. list of two-element lists)
; of every person in the tree and his or her patronus. For example, assuming 
; that HARRY is a tree representing Harry Potter and that he has no children
; (even though we know he does) the result would be: (list (list "Harry" "Stag")).
; 
; You must use ARTHUR as one of your examples.
; 


;; Person -> ListofPair
;; produce pair list of every person and patronus in given per's family tree
;;(define (pat-list per) empty) ;;stub
(check-expect (add-kids empty) empty)
(check-expect (pat-list LILY) (list (list "Lily" "N/A")))
(check-expect (pat-list WILLIAM) (list (list "William" "N/A")
                                       (list "Victorie" "N/A")))
(check-expect (pat-list ARTHUR) (list (list "Arthur" "Weasal")
                                      (list "William" "N/A")
                                      (list "Victorie" "N/A")
                                      (list "Charles" "N/A")
                                      (list "Percy" "N/A")
                                      (list "Fred" "Magpie")
                                      (list "George" "Magpie")
                                      (list "Ronald" "Dog")
                                      (list "Ginerva" "Horse")
                                      (list "Lily" "N/A")
                                      (list "Albus" "N/A")
                                      (list "James" "N/A")))

(define (pat-list p)
  (cons (list (person-name p)
              (person-patronus p)
        )
       (add-kids (person-kids p))
  )
)

(define (add-kids lop)
  (cond [(empty? lop) empty]
        [else
         (append (pat-list (first lop))
                 (add-kids (rest lop)))]))

; PROBLEM 4:
; 
; Design a function that produces the names of every person in a given tree 
; whose wands are made of a given material. 
; 
; You must use ARTHUR as one of your examples.
; 


;; Person -> ListofString
;; produce list of names that share same wand material as input i
;; (define (find-wand per i) empty) ;;stub

(check-expect (find-wand-lop empty "x") empty)
(check-expect (find-wand LILY "N/A") (list "Lily"))
(check-expect (find-wand WILLIAM "Wood and Core") (list "William"))
(check-expect (find-wand WILLIAM "N/A") (list "Victorie"))
(check-expect (find-wand WILLIAM "x") empty)
(check-expect (find-wand ARTHUR "Wood and Core") (list "Arthur" "William" "Percy" "Fred" "George"))
(check-expect (find-wand ARTHUR "Yew") (list "Ginerva"))

(define (find-wand p i)
  (if (equal? (person-wand p) i)
       (cons (person-name p) (find-wand-lop (person-kids p) i))
       (find-wand-lop (person-kids p) i)
  )
)

(define (find-wand-lop lop i)
  (cond [(empty? lop) empty]
        [else
         (append (find-wand (first lop) i)
                 (find-wand-lop (rest lop) i))]))

(find-wand ARTHUR "x")
(find-wand ARTHUR "N/A")
(find-wand ARTHUR "Wood and Core")