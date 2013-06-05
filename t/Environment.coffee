t = require '../lib/tester.coffee'
Environment = require('../lib/env.coffee').Environment
GlobalEnvironment = require('../lib/env.coffee').GlobalEnvironment

e1 = new Environment ['a'], [1]

t.ok e1.find('a')['a'] is 1, 'find works'
try
  e1.find('b')
catch error
  t.ok error.toString().match(/TypeError: Cannot call method 'find' of undefined/), 'find fails'

e2 = new Environment ['b'], [2], e1

t.ok e2.find('b')['b'], 'find works for child env'
t.ok e2.find('a')['a'], 'find works for parent env'

e3 = new Environment ['c'], [3], e2
e3.update { d: 4 }
t.ok e3.find('d')['d'], 'update works'

ge = new GlobalEnvironment()
t.ok ge.find('+')?, 'global environment constructed'
t.ok ge.find('+')['+'](1, 2) is 3, 'global methods installed'

t.done()
