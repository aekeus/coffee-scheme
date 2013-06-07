Symbol = require('../lib/symbol.coffee').Symbol

class Environment
  constructor: (params, args, outer) ->
    for p, i in params
      @[p] = args[i]
    @outer = outer

  find: (v) ->
    if @[v]?
      @
    else
      if @.outer?
        @.outer.find v
      else
        throw "symbol not found #{v}"

  update: (o) ->
    for k, v of o
      @[k] = v

class GlobalEnvironment extends Environment
  constructor: ->
    @.update
      '+': (a, b) -> a + b
      '-': (a, b) -> a - b
      '*': (a, b) -> a * b
      '/': (a, b) -> a / b

exports.Environment = Environment
exports.GlobalEnvironment = GlobalEnvironment
