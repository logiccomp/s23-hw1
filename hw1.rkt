#lang isl-spec

;; Problem 1: 
;;
;; Translate the following expressions in logic into corresponding function definitions. 
;; Note that the number (and names) of arguments may be different for the different 
;; expressions, as they do not all use the same variables.

;; Template (part p1) to fill in:

;; (P /\ Q) \/  ~(R /\ S)
(define (p2 ...) ...)

;; P -> ~Q
(define (p3 ...) ...)

;; ~(Q /\ ~Q) = T
(define (p4 ...) ...)


;; part p1


;; Problem 2:
;;
;; Prove that the two following equalities (these are De Morgan's Laws) hold for all 
;; possible assignments (i.e., are _valid_) by first defining them (p5 and p6) 
;; and then defining their truth tables using check-expect. 
;; Remember to include all possible combinations of inputs!

;; Template (part p2) to fill in:

;; ~(P /\ Q) = ~P \/ ~Q
(define (p5 ...) ...)
(check-expect (p5 ...) ...)
; ...

;; ~(P \/ Q) = ~P /\ ~Q
(define (p6 ...) ...)
(check-expect (p6 ...) ...)
; ...

;; part p2

;; Problem 3:
;;
;; For each operator, define a version of it in terms of just `if`.
;; You are welcome to validate your encodings using truth-table tests, but 
;; you are not required. 

;; Template (part p3) to fill in:

;; /\
(define (op_and ...) ...)

;; \/
(define (op_or ...) ...)

;; ->
(define (op_implies ...) ...)

;; =
(define (op_equal ...) ...)

;; ⊕ (exclusive or)
(define (op_xor ...) ...)


;; part p3


;; Problem 4:
;;
;; Perform simplifications to remove redundant variables for the three problems below, and include 
;; truth tables that confirm that your simplifications were correct. We are giving you the
;; expressions written both in logical syntax and in the ISL-Spec code that we expect 
;; you to simplify & test with.

;; Template (part p4) to fill in:

;; (P /\ R) \/ (Q /\ ~Q)
(define (p9 P Q R)
  (or (and P R) 
      (and Q (not Q))))
(define (p9s P Q R) 
  ...)

;; (P /\ Q /\ P) \/ (Q /\ R)
(define (p10 P Q R)
    (or (and P Q P) 
        (and Q R)))
(define (p10s P Q R)
    ...)

;; (P /\ Q /\ R) \/ (~Q /\ S /\ Q)
(define (p11 P Q R S)
    (or (and P Q R)
        (and (not Q) S Q)))
(define (p11s P Q R S)
  ...)

;; part p4