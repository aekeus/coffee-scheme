Symbol = require('../lib/symbol.coffee').Symbol

class Parser
  constructor: ->

  tokenize: (s) ->
    s = s.replace( /\(/g, ' ( ')
    s = s.replace( /\)/g, ' ) ')
    x for x in s.split(' ') when x isnt ''

  atom: (v) ->
    if isNaN parseFloat(v)
      new Symbol(v)
    else
      parseFloat(v)

  read: (s) -> @read_from @tokenize s

  read_from: (tokens) ->
    if tokens.length is 0
      throw "unexpected EOF"
    token = tokens.shift()
    if token is '('
      L = []
      while tokens[0] isnt ')'
        L.push @read_from tokens
      tokens.pop()
      L
    else if token is ')'
      throw 'unexpected token'
    else
      @atom token

exports.Parser = Parser
