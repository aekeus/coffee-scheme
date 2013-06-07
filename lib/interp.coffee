Environment = require('../lib/env.coffee').Environment
Symbol      = require('../lib/symbol.coffee').Symbol

isSymbol = (sym, s) -> sym.toString() is s

evaluate = (x, env) ->
  if x instanceof Symbol
    # instance of Symbols will return the current binding
    # within the hierarchy of environments for that Symbol
    env.find(x)[x]
  else if x not instanceof Array
    # anything else (that is not an Array) is returned
    x
  else if isSymbol x[0], 'quote'
    # return the thing quoted for a quote expression
    x[1]
  else if isSymbol x[0], 'if'
    [i, test, conseq, alt] = x
    evaluate((if evaluate(test, env) then conseq else alt), env)
  else if isSymbol x[0], 'define'
    [i, k, v] = x
    env[k] = evaluate(v, env)
  else if isSymbol x[0], 'set!'
    [i, k, v] = x
    env.find(k)[k] = evaluate(v, env)
  else if isSymbol x[0], 'lambda'
    [i, vars, exp] = x
    ->
      args = [].slice.call(arguments)
      evaluate( exp, new Environment( vars, args, env ) )
  else if isSymbol x[0], 'begin'
    v = null
    for exp in x[1..]
      do (exp) ->
        v = evaluate(exp, env)
    v
  else
    exps = (evaluate(exp, env) for exp in x)
    func = exps.shift()
    func.apply null, exps

exports.evaluate = evaluate
