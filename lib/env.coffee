Symbol = require('../lib/symbol')

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

module.exports = Environment
