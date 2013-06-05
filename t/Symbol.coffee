t = require '../lib/tester.coffee'
Symbol = require('../lib/symbol.coffee').Symbol

s = new Symbol('A')
t.eq s.toString(), 'A', 'Symbol created and read corrrectly'

t.done()
