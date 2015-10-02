size = exports.size = (a) -> [a.length, a[0].length]

zeros = exports.zeros = (r, c) -> ((0 for x in [1..c]) for y in [1..r])
ones = exports.ones = (r, c) -> ((1 for x in [1..c]) for y in [1..r])
eye = exports.eye = (s) ->
  S = zeros(s, s)
  S[i][i] = 1 for i in [0..s-1]
  S

transpose = exports.transpose = (A) ->
  sa = size(A)
  T = zeros sa[1], sa[0]
  for r in [0..A.length-1]
    for c in [0..A[0].length-1]
      T[c][r] = A[r][c]
  T

extractColumn = exports.extractColumn = (A, i) ->
  r = []
  for a in A
    r.push [a[i]]
  r

sumOfPairWiseMultiply = (a, b) ->
  sum = 0
  sum += a[i] * b[i] for i in [0..a.length-1]
  sum

dot = exports.dot = (a, b) ->
  as = size a
  bs = size b
  throw "Invalid sizes #{as}, #{bs}" unless as[1] is bs[0]
  R = zeros(as[0], bs[1])

  for rp in [0..a.length-1]
    for cp in [0..b[0].length-1]
      r = a[rp]
      c = transpose(extractColumn(b, cp))[0]
      R[rp][cp] = sumOfPairWiseMultiply r, c
  R

map = exports.map = (A, f) ->
  M = zeros size(A)[0], size(A)[1]
  for r in [0..A.length-1]
    for c in [0..A[0].length-1]
      M[r][c] = f(A[r][c])
  M

pnorm = exports.pnorm = (vec) ->
  sum = 0
  sum += (v * v) for v in vec
  Math.sqrt sum

pnormvec = exports.pnormvec = (vec) ->
  pnorm (r[0] for r in vec)

normalizeVector = exports.normalizeVector = (vec) ->
  norm = pnormvec vec
  ([r[0] / norm] for r in vec)

sumOfVector = exports.sumOfVector = (vec, column=0) ->
  sum = 0
  sum += v[0] for v in vec
  sum

eigvecs = exports.eigvecs = (A, delta=0.00001) ->
  rows = size(A)[0]
  initial = ones(rows, 1)
  initial_sum = sumOfVector initial
  iterations = 0
  while 1
    iterations += 1
    initial = normalizeVector( dot(A, initial) )
    new_sum = sumOfVector initial
    break if Math.abs(new_sum - initial_sum) < delta
    initial_sum = new_sum
  initial
