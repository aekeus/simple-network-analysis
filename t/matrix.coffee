t = require('../lib/tester.coffee')
m = require('../lib/matrix.coffee')

m1 = [
  [1, 2, 3],
  [4, 5, 6]
]

m2 = [
  [2, 5],
  [3, 6],
  [4, 7]
]

t.cmp m.size(m1), [2, 3], 'size correct'
t.cmp m.size(m2), [3, 2], 'size correct'

t.cmp m.extractColumn(m2, 1), [[5], [6], [7]], 'extractColumn works'

t.cmp m.zeros(2, 3), [[0,0,0],[0,0,0]], 'zeros works'
t.cmp m.ones(2, 3), [[1,1,1],[1,1,1]], 'ones works'

t.cmp m.eye(3), [[1, 0, 0], [0, 1, 0], [0, 0, 1]], 'identity'

t.cmp m.transpose(m2), [[2, 3, 4], [5, 6, 7]], 'transpose works'

mult = m.dot m1, m2
t.cmp mult, [[20, 38], [47, 92]], "mult worked"

t.cmp m.dot(m1, m.eye(3)), m1, 'mult by identity works'

dbl = (v) -> v * 2
t.cmp m.map(m2, dbl), [[4,10],[6,12],[8,14]], 'map works'

t.done()
