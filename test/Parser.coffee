test = require('tap').test

Parser = require('../lib/parser')
Symbol = require('../lib/symbol')

test "Parser", (t) ->

  p = new Parser()
  t.deepEqual p.tokenize('()'), ['(',')'], 'simple parser'
  t.deepEqual p.tokenize('(- 1 2)'), ['(','-', '1', '2', ')'], 'complex parse'
  t.deepEqual p.tokenize('(+ 1 (- 4 2))'), ['(','+', '1', '(', '-', '4', '2', ')', ')'], 'complex parse'

  batom = p.atom('B')
  t.ok batom instanceof Symbol, 'Symbol created via atom'
  t.ok batom.toString() is 'B', 'Symbol has correct value'

  fatom = p.atom('3.1415')
  t.ok not isNaN(fatom) , 'number created via atom'

  try
    p.read_from []
  catch error
    t.ok error.toString().match(/unexpected EOF/), 'empty tokens trapped'

  tokens = p.read_from ['(', '+', '1', '(', '+', '2', '3', ')', ')']
  t.deepEqual tokens, [ { s: '+' }, 1, [ { s: '+' }, 2, 3 ] ], 'read_from correct'

  stringified = p.toString p.read_from p.tokenize '(+ 1 (- 4 3))'
  t.equal stringified, '(+ 1 (- 4 3))', 'stringification worked'

  t.end()
