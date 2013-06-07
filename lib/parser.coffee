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

  parse: (s) -> @read_from @tokenize s

  read_from: (tokens, d=0) ->
    if tokens.length is 0
      throw "unexpected EOF"
    token = tokens.shift()
    if token is '('
      L = []
      while tokens[0] isnt ')'
        L.push @read_from tokens, d+1
      tokens.shift()
      L
    else if token is ')'
      throw 'unexpected token'
    else
      @atom token

  toString: (tree) ->
    if tree instanceof Array
      '(' + (@toString(e) for e in tree).join(' ') + ')'
    else
      tree.toString()

  repl: (prompt='>') ->


exports.Parser = Parser
