;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |L3 lookup-in-bst-starter|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; lookup-in-bst-starter.rkt

; 
; Consider the following data definition for a binary search tree: 
; 


;; Data definitions:

(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree
; .

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST7 (make-node 7 "ruf" false false))
(define BST4 (make-node 4 "dcj" false BST7))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST14 (make-node 14 "olp" false false))
(define BST27 (make-node 27 "wit" BST14 false))
(define BST50 (make-node 50 "dug" false false))
(define BST42 (make-node 42 "ily" BST27 BST50))
(define BST10 (make-node 10 "why" BST3 BST42))
#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic-distinct: false
;;  - compound: (make-node Integer String BST BST)
;;  - self reference: (node-l t) has type BST
;;  - self reference: (node-r t) has type BST

;; Functions:


; PROBLEM:
; 
; Complete the design of the lookup-key function below. Note that because this is a search function 
; it will sometimes 'fail'. This happens if it is called with an key that does not exist in the BST
; it is provided. If this happens the function should produce false. The signature for such a function
; is written in a special way as shown below.
; 

; .

;; BST Natural -> String or false
;; Try to find node with given key, if found produce value; if not found produce false.
;;(define (lookup-key t k) "") ;;stub
(check-expect (lookup-key BST7 2) false)
(check-expect (lookup-key BST7 7) "ruf")
(check-expect (lookup-key BST3 4) "dcj") ;; R success
(check-expect (lookup-key BST3 1) "abc") ;; L success
(check-expect (lookup-key BST10 1) "abc") ;; L L success
(check-expect (lookup-key BST10 4) "dcj") ;; L R success
(check-expect (lookup-key BST10 27) "wit") ;; R L success
(check-expect (lookup-key BST10 50) "dug") ;; R R success

(define (lookup-key t k)
  (cond [(false? t) false]
        [else
         (cond [(= (node-key t) k) (node-val t)]
               [(< (node-key t) k) (lookup-key (node-r t) k)]
               [(> (node-key t) k) (lookup-key (node-l t) k)]
         )
        ]
   )
)

(lookup-key BST10 14)
(lookup-key BST10 5)