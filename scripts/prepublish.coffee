##
# Updates the package.json readme field from the README.md.
#

fs = require('fs')

fs.readFile "#{__dirname}/../package.json", 'utf8', (err, data) ->
  throw(err) if err
  obj = JSON.parse data
  fs.readFile "#{__dirname}/../README.md", 'utf8', (err, data) ->
    throw(err) if err
    obj['readme'] = data #data.replace(/\n/g, '\\n').replace(/"/, '\\"')
    fs.writeFile "#{__dirname}/../package.json", JSON.stringify(obj, null, '  '), (err) ->
      throw(err) if err
