;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |L1 test file|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;;CONSTANTS
(define TEXT-SIZE  14)
(define TEXT-COLOR "BLACK")

(define WIDTH 30) ;;added to given list to simplify troubleshooting
(define MTTREE (rectangle WIDTH 1 "solid" "white"))

(define LW 20)
(define RW 20)

;;Data definitions
(define-struct elt (name data subs))
;; Element is (make-elt String Integer ListOfElement)
;; interp. An element in the file system, with name, and EITHER data or subs.
;;         If data is 0, then subs is considered to be list of sub elements.
;;         If data is not 0, then subs is ignored.

;; ListOfElement is one of:
;;  - empty
;;  - (cons Element ListOfElement)
;; interp. A list of file system Elements
; .

(define F1 (make-elt "F1" 1 empty))
(define F2 (make-elt "F2" 2 empty))
(define F3 (make-elt "F3" 3 empty))
(define D4 (make-elt "D4" 0 (list F1 F2)))
(define D5 (make-elt "D5" 0 (list F3)))
(define D6 (make-elt "D6" 0 (list D4 D5)))
#;
(define (fn-for-element e)
  (... (elt-name e)    ;String
       (elt-data e)    ;Integer
       (fn-for-loe (elt-subs e))))
#;
(define (fn-for-loe loe)
  (cond [(empty? loe) (...)]
        [else
         (... (fn-for-element (first loe))
              (fn-for-loe (rest loe)))])) 

(check-expect (render-tree F3) (text "F3" TEXT-SIZE TEXT-COLOR))
(check-expect (render-tree D5) (above
                                         (text "D5" TEXT-SIZE TEXT-COLOR)
                                         (add-line MTTREE ;;false
                                                   (/ LW 2) 0 ;;x1 y1
                                                   (/ LW 2) LW;;x2 y2
                                                   TEXT-COLOR
                                         )
                                         (text "F3" TEXT-SIZE TEXT-COLOR)
                                        )
)
(check-expect (render-tree D4) (above
                                         (text "D4" TEXT-SIZE TEXT-COLOR)
                                         (beside
                                          (add-line MTTREE ;;false
                                                   LW 0 ;;x1 y1
                                                   (/ LW 2) (/ (+ LW RW) 4);;x2 y2
                                                   TEXT-COLOR
                                          )
                                          (add-line MTTREE ;;false
                                                    LW 0 ;;x1 y1
                                                    (+ LW (/ RW 2)) (/ (+ LW RW) 4);;x2 y2
                                                    TEXT-COLOR
                                          )
                                         )
                                         (beside                                     
                                          (text "F1" TEXT-SIZE TEXT-COLOR)
                                          MTTREE
                                          (text "F2" TEXT-SIZE TEXT-COLOR)
                                          
                                         )
                                        )
)

(define (render-tree e)
  (local [
          (define (image-tree---element e)
            (if (zero? (elt-data e)) ;;true if subs, false if data
                (above ;;true
                 (text (elt-name e) TEXT-SIZE TEXT-COLOR)
                 (print-spoke (length (elt-subs e)))
                 (image-tree---loe (elt-subs e))
                 )
                (text (elt-name e) TEXT-SIZE TEXT-COLOR) ;;false
                )
            )

          (define (image-tree---loe loe)
            (cond [(empty? loe) MTTREE]
                  [else
                   (if (> (length loe) 1) ;;check if one or more elements exist
                       ;;TRUE
                       (beside
                        (image-tree---element (first loe))
                        MTTREE
                        (image-tree---loe (rest loe))
                        )

                       ;;FALSE
                       (image-tree---element (first loe))
                       )
                   ]
                  )
            )

          ;;Integer -> Image
          ;;print row of spokes according to list length
          ;;(define (print-spoke i) MTTREE) ;;stub

          (define (print-spoke i)
            (if (> i 1) ;;check if one or more elements exist
                ;;TRUE
                (beside
                 (add-line MTTREE ;;false
                           LW 0 ;;x1 y1
                           (/ LW 2) (/ (+ LW RW) 4);;x2 y2
                           TEXT-COLOR
                           )
                 (add-line MTTREE ;;false
                           LW 0 ;;x1 y1
                           (+ LW (/ RW 2)) (/ (+ LW RW) 4);;x2 y2
                           TEXT-COLOR
                           )
                 )

                ;;FALSE
                (add-line MTTREE ;;false
                          (/ LW 2) 0 ;;x1 y1
                          (/ LW 2) LW;;x2 y2
                          TEXT-COLOR
                          )
                )
            )
         ]
    (render-tree e)
    )
)

(render-tree D6)