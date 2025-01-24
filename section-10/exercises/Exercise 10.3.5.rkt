#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
(define-struct circle (center radius color))
(define-struct rectangle (nw-corner width height color))
;; A shape is either
;; 1. a structure: (make-circle c r color)
;; where c is a posn, r a number and color a symbol.
;; 2. a structure: (make-rectangle corner w h color)
;; where corner is a posn, w and h a number and color a symbol

;; A list of shapes consists of either:
;; 1. empty
;; 2. (cons shape list of shape) where a shape can be a circle or rectangle struct


;; draw-losh : list of shape -> true
;; Draws a list of gives shapes
(define (draw-losh a-losh)
  (cond
    [(empty? a-losh) true]
    [else (and (draw-shape (first a-losh))
               (draw-losh (rest a-losh)))]))


;; clear-losh : list-of-shape -> true
;; Clears a list of gives shapes
(define (clear-losh a-losh)
  (cond
    [(empty? a-losh) true]
    [else (and (clear-shape (first a-losh))
               (clear-losh (rest a-losh)))]))


;; draw-and-clear-picture : list-of-shape -> true
(define (draw-and-clear-picture pic)
  (and (draw-losh pic)
       (sleep-for-a-while 1)
       (clear-losh pic)))

;; draw-shape : shape -> true
;; Draws a given shape on the canvas
(define (draw-shape a-shape)
  (cond
    [(circle? a-shape)
     (draw-circle (circle-center a-shape) (circle-radius a-shape) (circle-color a-shape))]
    [(rectangle? a-shape)
     (draw-solid-rect (rectangle-nw-corner a-shape)  (rectangle-width a-shape) (rectangle-height a-shape) (rectangle-color a-shape))]
))

;; clear-shape : shape -> true
;; Clears a given shape on the canvas
(define (clear-shape a-shape)
  (cond
    [(circle? a-shape)
     (clear-circle (circle-center a-shape) (circle-radius a-shape) (circle-color a-shape))]
    [(rectangle? a-shape)
     (clear-solid-rect (rectangle-nw-corner a-shape)  (rectangle-width a-shape) (rectangle-height a-shape) (rectangle-color a-shape))]
))

;; TESTS
(start 300 300)
(define FACE (cons (make-circle (make-posn 50 50) 40 'red)
                   (cons (make-rectangle (make-posn 30 20) 5 5 'blue)
                         (cons (make-rectangle (make-posn 65 20) 5 5 'blue)
                               (cons (make-rectangle (make-posn 40 75) 20 10 'red)
                                     (cons (make-rectangle (make-posn 45 35) 10 30 'blue) empty))))))

(draw-and-clear-picture FACE)
