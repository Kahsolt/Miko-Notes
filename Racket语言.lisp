; Racket是类Scheme的LISP方言

零.REPL
(load "test.rkt")     ; load script
(enter! "test.rkt")   ; load & run script
(time E)
(display E)
(print E)

一.基础
1.类型
  数字    10 #x3F 3.14 1/2 3.8e+2 +inf.0 1+2i
    （number? 1)   ; also integer?/rational?/real?/complex?
  布尔    #f #t   ; (none-#f value taken as #t)
    (boolean? #f)
  字符    #\u0011
    (char? #\A)
  字符串  "Hello, world!"  "Benjamin \"Bugsy\" Siegel"  "λx:(μα.α→α).xx"
    (string? "")
  字节串  #"Apple" #"wow"
    （byte? #"Apple")
  符号  'map  (quote reduce)
    (symbol? 'map)
    (list? (quote (reduce asd)))  ; #t
  过程
    (define (F x) 42)
    (procedure? F)
2.运算
  (+/-/*// a b)
  (>/</>=/<= a b)
  （= a b）/(equal? a b)/(eqv? a b)/(eq? a b)
  (inexact->exact x)

3.分支
(if (> 2 3) "bigger" "smaller")
(if (equal? 2 "hello" (substring s 0 5)) "hi!" "huh?")
(if (and (string? s)
         (>= (string-length s) 5)
         (equal? "hello" (substring s 0 5)))
    "hi!" "huh?")
  (define (double v)
  ((if (string? v) string-append +) v v))
(cond
  [(equal? "hello" (substring s 0 5)) "hi!"]
  [(equal? "goodbye" (substring s 0 7)) "bye!"]
  [(equal? "?" (substring s (- (string-length s) 1))) "I don't know"]
  [else "huh?"]))

4.函数/匿名函数
(define pie 3)             ; defines pie to be 3
(define (piece str)        ; defines piece as a function
  (substring str 0 pie))   ;  of one argument
(define (bake flavor)
  (printf "preheating oven...\n")
  (string-append flavor " pie"))
(define (double v)
  ((if (string? v) string-append +) v v))
(define (twice f v)        ; 高阶函数
  (f (f v)))

((lambda (s)
  (string-append s "!") "hello")

5.绑定
(define (converse s)
  ; local definition
  (define (starts? s2)                ; func 'starts?' is local to 'converse'
    (define len2 (string-length s2))  ; var 'len2' is local to 'starts?'
    (and (>= (string-length s) len2)
         (equal? s2 (substring s 0 len2))))
  ; expression body
  (cond
   [(starts? "hello") "hi!"]
   [(starts? "goodbye") "bye!"]
   [else "huh?"]))

(let ([x (random 4)]  ; local binding
      [o (random 4)])
  ; expression body
  (cond
    [(> x o) "X wins"]
    [(> o x) "O wins"]
    [else "cat's game"]))
(let* ([x (random 4)]
       [o (random 4)]
       ; 'let*' allows bindings use each other
       [diff (number->string (abs (- x o)))])
  (cond
    [(> x o) (string-append "X wins by " diff)]
    [(> o x) (string-append "O wins by " diff)]
    [else "cat's game"]))
    
6.数据结构:pair/list/vector
构造
  '(key . val)      ; literal pair
  '("age" . 13)
  (cons 1 2)        ; got pair (1 . 2)
  (cons (list 1) 2) ; got pair ((1) . 2)
  
  '(item1, item2, ietm3)    ; literal list
  '(1 3.14 "hello")
  '()/empty/null            ; empty list
  (list "red" "green" "blue")
  (list 1 2 3 4 5)
    (cons 1 (list 2))         ; got list (1 2)
    (cons (list 1) (list 2))  ; got list ((1) 2)

  #("a" "b" "c")      ; literal vector
  #(name (that tune))
  (vector 1 2 3)      ; vector: fixed-length list
运算
  （list? L)/(pair? P)/(empty? L)/(cons? L)  ; cons? == not empty?
  （length L)
  (member item L)
  (car L)/(first L)   ; list head
  (cdr L)/(rest L)    ; list tail
  (last L)
  (list-ref L index)  ; L[index]
  (append L L2)
  (reverse L)
高阶函数
  (map sqrt (list 1 4 9 16))
    ; (for/list ([i (list 1 4 9 16)]) (sqrt i))
  (map (lambda (i) (string-append i "!"))
       (list "peanuts" "popcorn" "crackerjack"))
  (map (lambda (s n) (substring s 0 n))
       (list "peanuts" "popcorn" "crackerjack")
       (list 6 3 7))
  (andmap string? (list "a" "b" 6))
  (ormap number? (list "a" "b" 6))

  (filter string? (list "a" "b" 6))
  (filter positive? (list 1 -2 6 7 0))
  
  (foldl (lambda (elem v) (+ v (* elem elem)))  ; reduce
    0 '(1 2 3))
递归
(define (list-length ls)
  (cond
    [(empty? ls) 0]
    [else (+ 1 (list-length (rest ls)))]))
(define (list-map f lst)
  (cond
    [(empty? lst) empty]
    [else (cons (f (first lst)) (list-map f (rest lst)))]))
(define (list-map f lst)
  (for/list ([i lst])   ; iteration rather than recursion, quod est tail call
    (f i)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#lang racket

(define (extract str)
  (substring str 4 7))
 
(extract "the cat out of the bag")
(display "\n")

; fuzzbar
(define (mod a b)
  (if (>= a b) (mod (- a b) b) a))
(define (fuzzbar n)
  (cond
    [(and (= 0 (mod n 3)) (= 0 (mod n 5))) (println "FuzzBar")]
    [(= 0 (mod n 5)) (println "Fuzz")]
    [(= 0 (mod n 3)) (println "Bar")]
    [else (println "Uha")]))

(fuzzbar 1)
(fuzzbar 9)
(fuzzbar 25)
(fuzzbar 15)
(display "\n")
    
; hanoi
(define (move a c)
  (printf "~a -> ~a\n" a c))
(define (hanoi a b c n)
  (cond
    [(= n 1) (move a c)]
    [else (and
      (hanoi a c b (- n 1))
      (move a c)
      (hanoi b a c (- n 1)))]))

(hanoi "A" "B" "C" 3)
(display "\n")

