#!/usr/bin/env coffee
fs = require('fs')
exec = require('child_process').exec

red   = (t) -> "\u001b[31m#{t}\u001b[0m"
green = (t) -> "\u001b[32m#{t}\u001b[0m"

passed = 0
failed = 0
matcher = new RegExp(/(\d+) passed, (\d+) failed/)

files = (f for f in fs.readdirSync('t') when f.match /^(.*)\.coffee$/)
file_count = files.length
for f in files
  do (f) ->
    child = exec "coffee t/#{f}", (err, stdout, stderr) ->
      console.log "#{f}"
      o = stdout
      console.log o
      matches = matcher.exec(o)
      if matches?
        passed += parseInt matches[1]
        failed += parseInt matches[2]
      file_count -= 1
      console.log " #{green passed} passed, #{failed} failed (Aggregate)" if file_count is 0
      console.log stderr if stderr?
