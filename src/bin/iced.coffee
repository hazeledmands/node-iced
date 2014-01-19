helmsman = require 'helmsman'
pkg = require '../package.json'

cli = helmsman()

cli.on '--help', ->
  console.log pkg.description

cli.parse()
