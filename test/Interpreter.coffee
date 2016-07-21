test = require('tap').test

evaluate          = require('../lib/interp')
Environment       = require('../lib/env')
GlobalEnvironment = require('../lib/global')
Symbol            = require('../lib/symbol
')

test "Interpreter", (t) ->

  ge = new GlobalEnvironment()
  e = new Environment(['a'], [5], ge)

  t.equal evaluate(new Symbol('a'), e), 5, 'Symbol found and returned'
  t.equal evaluate(4, e), 4, 'constant returned as is'
  t.equal evaluate(['quote', 99], e), 99, 'quote handled'

  t.equal evaluate( ['if', 1, 5, 6], e ), 5, 'if handles conseq'
  t.equal evaluate( ['if', 0, 5, 6], e ), 6, 'if handles else'

  t.ok evaluate( ['define', 'blag', 99], e ), 'define value in env'
  t.equal e['blag'], 99, 'definition stuck'

  t.ok evaluate( [new Symbol('+'), 1, 2], e ) is 3, 'function application'

  l = evaluate( ['lambda', [new Symbol('z')], [new Symbol('+'), new Symbol('z'), 1]], e)
  t.equal l(5), 6, 'lambda works'

  t.ok evaluate( ['begin', 1, 2, 3], e) is 3, 'begin works'

  t.ok evaluate( [new Symbol('set!'), 'blag', 97], e ), 'set! value in env'
  t.equal e['blag'], 97, 'set! stuck'

  t.end()
