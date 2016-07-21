Environment = require("./env")

class GlobalEnvironment extends Environment
  constructor: ->
    @.update
      '+': (a, b) -> a + b
      '-': (a, b) -> a - b
      '*': (a, b) -> a * b
      '/': (a, b) -> a / b
      'sqrt': (x) -> Math.sqrt(x)

module.exports = GlobalEnvironment
