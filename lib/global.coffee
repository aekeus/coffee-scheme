Environment = require("./env").Environment

class GlobalEnvironment extends Environment
  constructor: ->
    @.update
      '+': (a, b) -> a + b
      '-': (a, b) -> a - b
      '*': (a, b) -> a * b
      '/': (a, b) -> a / b

exports.GlobalEnvironment = GlobalEnvironment
