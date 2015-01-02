r = require '../lib/reader.coffee'
m = require '../lib/matrix.coffee'

argv = require('optimist')
  .demand(['file'])
  .argv

fn = argv.file
s = r.read fn

console.log s
row_relations = m.dot s.membership, m.transpose(s.membership)
column_relations = m.dot m.transpose(s.membership), s.membership

console.log row_relations
console.log column_relations

row_eig = m.eigvecs row_relations
col_eig = m.eigvecs column_relations

line = (v, max=1.0, width=40) ->
  ('X' for x in [0..parseInt(v/max*width)]).join('')

for heading, idx in s.row_headings
  console.log s.row_headings[idx], Math.round(row_eig[idx][0] * 1000) / 1000, line row_eig[idx][0]

for heading, idx in s.column_headings
  console.log s.column_headings[idx], Math.round(col_eig[idx][0] * 1000) / 1000, line col_eig[idx][0]
