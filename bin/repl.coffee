evaluate          = require('../lib/interp.coffee').evaluate
Environment       = require('../lib/env.coffee').Environment
GlobalEnvironment = require('../lib/env.coffee').GlobalEnvironment
Symbol            = require('../lib/symbol.coffee').Symbol
Parser            = require('../lib/parser.coffee').Parser

ge = new GlobalEnvironment()
e = new Environment([], [], ge)
p = new Parser()

process.stdin.resume()
process.stdin.setEncoding('ascii')

console.log "\\h - help"

process.stdin.on 'data', (chunk) ->
  chunk = chunk.replace("\n", "")
  if chunk.match /\\ds/g
    console.log e
  else if chunk.match /\\q/g
    throw "done"
  else if chunk.match /\\h/g
    console.log "\\ds - display symbol table for global environment"
    console.log "\\q  - quit"
  else
    try
      console.log evaluate(p.read_from(p.tokenize(chunk)), e)
    catch err
      console.log err.toString()

process.stdin.on 'end', ->
