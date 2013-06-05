t = require '../lib/tester.coffee'
Parser = require('../lib/parser.coffee').Parser
Symbol = require('../lib/symbol.coffee').Symbol

p = new Parser()
t.cmp p.tokenize('()'), ['(',')'], 'simple parser'

batom = p.atom('B')
t.ok batom instanceof Symbol, 'Symbol created via atom'
t.ok batom.toString() is 'B', 'Symbol has correct value'

fatom = p.atom('3.1415')
t.ok not isNaN(fatom) , 'number created via atom'
t.close fatom, 3.1415, 'number has correct value'

t.done()
