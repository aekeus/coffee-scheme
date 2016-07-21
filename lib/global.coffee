Environment = require("./env").Environment

class GlobalEnvironment extends Environment
  constructor: ->
    @.update
      '+': (a, b) -> a + b
      '-': (a, b) -> a - b
      '*': (a, b) -> a * b
      '/': (a, b) -> a / b
      'sqrt': (x) -> Math.sqrt(x)

exports.GlobalEnvironment = GlobalEnvironment
