table = require 'text-table'

reader = require '../lib/reader.coffee'
m      = require '../lib/matrix.coffee'
t      = require '../lib/table'

argv = require('optimist')
  .demand(['file'])
  .argv

line = (v, max=1.0, width=40) ->
  ('X' for x in [0..parseInt(v/max*width)]).join('')

s = reader.read argv.file

console.log s
row_relations = m.dot s.membership, m.transpose(s.membership)
r[idx] = 0 for r, idx in row_relations

column_relations = m.dot m.transpose(s.membership), s.membership
r[idx] = 0 for r, idx in column_relations

console.log row_relations
console.log column_relations

if argv.html
  console.log t.table s.row_headings, s.column_headings, s.membership, 'Member', 'Group'
  console.log t.table s.row_headings, s.row_headings, row_relations, 'Member', 'Member'
  console.log t.table s.column_headings, s.column_headings, column_relations, 'Group', 'Group'
  
row_eig = m.eigvecs row_relations
col_eig = m.eigvecs column_relations

console.log "\nRow Centrality"
console.log table ([s.row_headings[idx], Math.round(row_eig[idx][0] * 1000) / 1000, line(row_eig[idx][0])] for heading, idx in s.row_headings)

console.log "\nColumn Centrality"
console.log table ([s.column_headings[idx], Math.round(col_eig[idx][0] * 1000) / 1000, line(col_eig[idx][0])] for heading, idx in s.column_headings)
