#!/usr/bin/env coffee
fs = require('fs')
exec = require('child_process').exec

files = (f for f in fs.readdirSync('t') when f.match /^(.*)\.coffee$/)
for f in files
  do (f) ->
    child = exec "coffee t/#{f}", (err, stdout, stderr) ->
      console.log "#{f}"
      o = stdout
      console.log o
      console.log stderr if stderr?
