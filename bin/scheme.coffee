fs = require 'fs'

evaluate          = require('../lib/interp.coffee').evaluate
Environment       = require('../lib/env.coffee').Environment
GlobalEnvironment = require('../lib/env.coffee').GlobalEnvironment
Symbol            = require('../lib/symbol.coffee').Symbol
Parser            = require('../lib/parser.coffee').Parser

ge = new GlobalEnvironment()
e = new Environment([], [], ge)
p = new Parser()

filename = process.argv[2]
throw "filename required" unless filename?

lines = fs.readFileSync(filename, 'utf-8').split "\n"
for line in lines
  line = line.replace /\n/, ''
  if line.length
    console.log "#{line} ->", evaluate p.parse(line), e
