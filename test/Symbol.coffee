test = require('tap').test

Symbol = require('../lib/symbol')

test "Symbol", (t) ->
  s = new Symbol('A')
  t.equal s.toString(), 'A', 'Symbol created and read corrrectly'

  t.end()
