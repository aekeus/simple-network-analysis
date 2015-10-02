th = (l) -> "<th>#{l}</th>"
td = (l) -> "<td>#{l}</td>"

exports.table = table = (row_labels, column_labels, values, row_header = '', column_header = '') ->
  b = "<table>"
  b += "<tr><th></th><th style='text-align: center;' colspan='#{column_labels.length - 1}'>#{column_header}</th></tr>"
  
  b += "<tr><th>#{row_header}</th>\n"
  for cl in column_labels
    b += "#{th cl}\n"
  b += "</tr>\n"
  for vr, idx in values
    b += "<tr>"
    b += th row_labels[idx]
    for v in vr
      b += td v
    b += "</tr>\n"
  b += "</table>"
  b
