Symbol = require('../lib/symbol.coffee').Symbol

class Parser
  constructor: ->

  tokenize: (s) ->
    x for x in s.replace('(', ' ( ').replace(')', ' ) ').split(' ') when x isnt ''

  atom: (v) ->
    if isNaN parseFloat(v)
      new Symbol(v)
    else
      parseFloat(v)

exports.Parser = Parser
