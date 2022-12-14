#lang scribble/manual
@require[scribble-math]
@require[scribble-math/dollar]
@require[racket/runtime-path]

@require["../../lib.rkt"]
@define-runtime-path[hw-file "hw1.rkt"]

@title[#:tag "hw1"]{Homework 1}

@bold{Released:} @italic{Wednesday, January 11, 2023 at 6:00pm}

@bold{Due:} @italic{Wednesday, January 18, 2023 at 6:00pm}

@nested[#:style "boxed"]{
What to Download:

@url{https://github.com/logiccomp/s23-hw1/raw/main/hw1.rkt}
}

Please start with this file, filling in where appropriate, and submit your homework to the @tt{HW1} assignment on Gradescope. This page has additional information, and allows us to format things nicely.

@section{Problem 1}

We can express propositional logic using boolean functions in ISL-Spec, a
language you are familiar with from Fundamentals 1 (as it's essentially the same as ISL+, which you used). 
Most are built in, but some
we will define. See the following table, which lists the logical operator and
the corresponding ISL-Spec function (or definition, if it's not built in).

@tabular[#:style 'boxed
         #:row-properties '(bottom-border ())
(list (list "operator in logic" "operator in ISL-Spec")
      (list ($ "\\land")  "and")
      (list ($ "\\lor")  "or")
      (list ($ "\\neg") "not")
      (list ($ "\\Rightarrow") "(lambda (P Q) (not (and P (not Q))))")
      (list ($ "\\equiv")  "boolean=?")
      (list ($ "\\otimes") "(lambda (P Q) (or (and P (not Q)) (and Q (not P))))")
      (list ($ "ite") "if")
      )]


For example, @${P \land Q} can be expressed as the following function:

@codeblock[#:keep-lang-line? #f]|{
#lang racket
(define (p1 P Q)
  (and P Q))
}|

Translate the following expressions in logic into corresponding function definitions, 
named @code{p2},@code{p3}, @code{p4}. Note that the number (and names) of arguments
may be different for the different expressions, as they do not all use the same variables.

@tabular[#:style 'boxed
         #:row-properties '(bottom-border ())
(list (list "definition name" "logical expression")
      (list (code "p2")  ($ "(P \\land Q) \\lor \\neg (R \\land S)"))
      (list (code "p3")  ($ "P \\Rightarrow \\neg Q"))
      (list (code "p4") ($ "\\neg (Q \\land \\neg Q) \\equiv T)")))]

Template code (included in file linked at top of page):

@minted-file-part["racket" "p1" hw-file]


@section{Problem 2}

Just as we can express propositional logical statements as code, we can also express proofs about propositional logic in code. 
These proofs are often written as truth tables, with the goal to show that a given expression is always true (or maybe is never true)
regardless of the assignment of variables. You can do this by enumerating, in a table, all possible assignments of variables.

For example, if we wanted to know that @${P \land \neg P} is false or @italic{unsatisfiable} (i.e., for all possible assignments of 
variables, the result in false), we can define the following truth table to prove it:

@tabular[#:style 'boxed
         #:row-properties '(bottom-border ())
(list (list ($ "P") ($ "P  \\land \\neg P"))
      (list ($ "T") ($ "F"))
      (list ($ "F") ($ "F")))
]

Here we see, regardless of whether we assign @${T} or @${F} to @${P}, our expression ends up @${F}. 

To do this in code, we can express each row of the truth table as a unit test. We can define the above expression as:

@codeblock[#:keep-lang-line? #f]|{
#lang racket
(define (p1 P)
  (and P (not P)))
}|

And then write the two lines of the truth table:

@codeblock[#:keep-lang-line? #f]|{
#lang racket
(check-expect (p1 #t) #f)
(check-expect (p1 #f) #f)
}|

This then corresponds to a proof that is @italic{verified} by running those tests. If one of our cases were wrong, we would 
get a test failure. 

For this problem, you should prove that the two following equalities (these are De Morgan's Laws) hold for all 
possible assignments (i.e., are @italic{valid}) by first defining them (@code{p5} and @code{p6}) 
and then defining their truth tables using @tt{check-expect}. 
@italic{Remember to include all possible combinations of inputs!}

@tabular[#:style 'boxed
         #:row-properties '(bottom-border ())
(list (list "equation name" "logical expression")
      (list (code "p5") ($ "\\neg (P \\land Q) \\equiv \\neg P \\lor \\neg Q"))
      (list (code "p6") ($ "\\neg (P \\lor Q) \\equiv \\neg P \\land \\neg Q")))]

Template code (included in file linked at top of page):

@minted-file-part["racket" "p2" hw-file]


@section{Problem 3}

We've seen that logical implication (@${\Rightarrow}) can be defined in 
terms of @${\land} and @${\neg} (including in the table in Problem 1). 

It turns out, there are many cases when you can define one operator in 
terms of another. 

In this exercise, for each operator, define a version of it in terms of just @code{if}. For example, 
@${\neg P}, would be represented as @code{(define (op_neg P) (if P #f #t))}. You are welcome to validate your
encodings using truth-table tests, but you are not required. 

@tabular[#:style 'boxed
         #:row-properties '(bottom-border ())
(list (list "operator" "definition name")
      (list ($ "\\land") (code "op_and"))
      (list ($ "\\lor") (code "op_or"))
      (list ($ "\\Rightarrow") (code "op_implies"))
      (list ($ "\\equiv") (code "op_equal"))
      (list ($ "\\otimes") (code "op_xor"))
      )]

Template code (included in file linked at top of page):

@minted-file-part["racket" "p3" hw-file]


@section{Problem 4}

Simplifying propositional formulas is an important topic, as simpler formulas, especially if they have fewer variables,
are easier to check for validity (truth), unsatisfiability (falsehood), etc. 

For example, if I have the expression @${P \land (Q \lor \neg Q)}, we can see that the 
subexpression @${Q \lor \neg Q} will always be true, no matter the assignment of @${Q}, and thus we 
could first simplify this to @${P \land T}. But since @${P \land T} is equivalent to just @${P}, 
we can further simplify.

In code, what this means is that the function:

@codeblock[#:keep-lang-line? #f]|{
#lang racket
(define (p7 P Q)
  (and P (or Q (not Q))))
}|

Is equivalent to the function:

@codeblock[#:keep-lang-line? #f]|{
#lang racket
(define (p7s P Q) P)
}|

And we can check that using a truth table, which has four rows since there are two variables.

@codeblock[#:keep-lang-line? #f]|{
#lang racket
(check-expect (p7 #t #t) (p7s #t #t))
(check-expect (p7 #t #f) (p7s #t #f))
(check-expect (p7 #f #t) (p7s #f #t))
(check-expect (p7 #f #f) (p7s #f #f))
}|

Here we left @code{Q} as an input to @code{p7s} to make it obvious that the truth table test is showing they are equivalent
on all inputs. Note that it is of course equivalent to a function that does not have the extra argument, but the truth table may
be harder to understand, so for this problem, we will write our simplified versions in this more verbose form, even when we can 
eliminate variables.

Your task, in this problem, is to perform simplifications of this form for the three problems below, and include 
truth tables that confirm that your simplifications were correct. We are giving you the
expressions written both in logical syntax and in the ISL-Spec code that we expect you to simplify & test with.

@tabular[#:style 'boxed
         #:row-properties '(bottom-border ())
(list (list "expression" "in code" "your simplified version")
    (list ($ "(P \\land R) \\lor (Q \\land \\neg Q)") 
(racketblock 
(define (p9 P Q R) 
  (or (and P R) 
       (and Q (not Q))))) 
(racketblock
(define (p9s P Q R) 
  ...)))
  (list ($ "(P \\land Q \\land P) \\lor (Q \\land R)")
(racketblock
(define (p10 P Q R)
  (or (and P Q P) 
      (and Q R))))
(racketblock
(define (p10s P Q R)
  ...)))
  (list ($ "(P \\land Q \\land R) \\lor (\\neg Q \\land S \\land Q)")
(racketblock
(define (p11 P Q R S)
  (or (and P Q R)
      (and (not Q) S Q))))
(racketblock
(define (p11s P Q R S)
  ...)))
)]

Template code (included in file linked at top of page):

@minted-file-part["racket" "p4" hw-file]
