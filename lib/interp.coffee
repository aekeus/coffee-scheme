Environment = require('../lib/env.coffee').Environment
Symbol      = require('../lib/symbol.coffee').Symbol

evaluate = (x, env) ->
  if x instanceof Symbol
    env.find(x)[x]
  else if x not instanceof Array
    x
  else if x[0] is 'quote'
    x[1]
  else if x[0] is 'if'
    [i, test, conseq, alt] = x
    eval((if eval(test, env) then conseq else alt), env)
  else if x[0] is 'define'
    [i, k, v] = x
    env[k] = v
  else if x[0] is 'set!'
    [i, k, v] = x
    env.find(k)[k] = v
  else if x[0] is 'lambda'
    [i, vars, exp] = x
    ->
      args = [].slice.call(arguments)
      evaluate( exp, new Environment( vars, args, env ) )
  else if x[0] is 'begin'
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
