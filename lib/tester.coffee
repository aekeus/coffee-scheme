exports.ok = (pred, msg) ->
  if pred
    console.log "OK #{msg}"
    0
  else
    console.log "not OK #{msg}"
    1

