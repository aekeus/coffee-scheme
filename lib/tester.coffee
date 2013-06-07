count = 0
ok_count = 0
not_ok_count = 0

ok = (pred, msg) ->
  count += 1
  if pred
    console.log "ok ... #{count} #{msg}"
    ok_count += 1
  else
    console.log "NOT OK ... #{count} #{msg}"
    not_ok_count += 1

exports.eq    = (a, b, msg) -> ok a is b, msg
exports.cmp   = (a, b, msg) -> ok JSON.stringify(a) is JSON.stringify(b), msg
exports.close = (a, b, msg) -> ok Math.abs(a - b) < 0.01, msg

exports.done  = ->
  if not_ok_count is 0
    not_ok_label = not_ok_count
  else
    not_ok_label = red(not_ok_count)
  console.log " #{ok_count} passed, #{not_ok_label} failed"

exports.ok = ok
