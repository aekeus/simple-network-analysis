test = require('tap').test
m = require('../lib/matrix.coffee')

test "matrix operations", (t) ->

  m1 = [
    [1, 2, 3],
    [4, 5, 6]
  ]

  m2 = [
    [2, 5],
    [3, 6],
    [4, 7]
  ]

  t.deepEqual m.size(m1), [2, 3], 'size correct'
  t.deepEqual m.size(m2), [3, 2], 'size correct'

  t.deepEqual m.extractColumn(m2, 1), [[5], [6], [7]], 'extractColumn works'

  t.deepEqual m.zeros(2, 3), [[0,0,0],[0,0,0]], 'zeros works'
  t.deepEqual m.ones(2, 3), [[1,1,1],[1,1,1]], 'ones works'

  t.deepEqual m.eye(3), [[1, 0, 0], [0, 1, 0], [0, 0, 1]], 'identity'

  t.deepEqual m.transpose(m2), [[2, 3, 4], [5, 6, 7]], 'transpose works'

  mult = m.dot m1, m2
  t.deepEqual mult, [[20, 38], [47, 92]], "mult worked"

  t.deepEqual m.dot(m1, m.eye(3)), m1, 'mult by identity works'

  dbl = (v) -> v * 2
  t.deepEqual m.map(m2, dbl), [[4,10],[6,12],[8,14]], 'map works'

  t.equal m.pnorm([2, 2, 2, 1]), Math.sqrt(13), 'pnorm works'
  t.equal m.pnormvec([[2], [2], [2], [1]]), Math.sqrt(13), 'pnormvec works'

  t.deepEqual m.size( m.normalizeVector([[2], [2], [2], [1]]) ), [4,1], 'normalizeVector right size'

  B = [
    [0,1,1,1]
    [1,0,1,0]
    [1,1,0,0]
    [1,0,0,0]
  ]

  result = [
    [ 0.611621670174778 ],
    [ 0.5227234610614816 ],
    [ 0.5227234610614816 ],
    [ 0.28184978106151987 ]
  ]

  eigen = m.eigvecs B

  for i in [0..3]
    t.equal eigen[i][0], result[i][0], "eigen row #{i} correct"

  t.end()
