(define adder (lambda (x) (lambda (y) (+ x y))))

(define oneadder (adder 1))

(oneadder 2)
