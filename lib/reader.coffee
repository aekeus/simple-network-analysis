fs = require 'fs'

m = require '../lib/matrix.coffee'

exports.read = (fn, encoding='utf-8') ->
  lines = (l for l in fs.readFileSync(fn, encoding).split("\n") when l.length)
  lines = (l.split(",") for l in lines)
  set =
    column_headings: lines[0]
    row_headings: l[0] for l in lines[1..]
    membership: m.map (l[1..] for l in lines[1..]), parseInt
