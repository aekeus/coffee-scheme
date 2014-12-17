test = require('tap').test

evaluate          = require('../lib/interp.coffee').evaluate
Environment       = require('../lib/env.coffee').Environment
GlobalEnvironment = require('../lib/env.coffee').GlobalEnvironment
Symbol            = require('../lib/symbol.coffee').Symbol
Parser            = require('../lib/parser.coffee').Parser

test "Integrated", (t) ->
  ge = new GlobalEnvironment()
  e = new Environment(['a'], [5], ge)
  p = new Parser()

  code = '(begin (define add (lambda (a b) (+ a b))) (add 1 2))'
  expression = p.read_from p.tokenize code
  t.equal evaluate(expression, e), 3, 'lambda expression evaluated'

  code = '((lambda (x) (* x x)) 5)'
  expression = p.read_from p.tokenize code
  t.equal evaluate(expression, e), 25

  expression = p.read_from p.tokenize '(+ 5 (* 2 3))'
  t.equal evaluate(expression, e), 11, 'simple expression evaluated'

  expression = p.read_from p.tokenize '(begin (define a 1) (define b 2) (if a a b))'
  t.equal evaluate(expression, e), 1, 'if expression evaluated'

  expression = p.read_from p.tokenize '(begin (define a 1) a)'
  t.equal evaluate(expression, e), 1, 'symbol lookup works'
  t.end()
