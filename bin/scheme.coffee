fs = require 'fs'

evaluate          = require('../lib/interp')
Environment       = require('../lib/env')
GlobalEnvironment = require('../lib/global')
Parser            = require('../lib/parser')

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
