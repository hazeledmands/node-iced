fs = require 'fs'
path = require 'path'

hashbang = "#!/usr/bin/env node\n\n"
binDir = path.resolve(__dirname, '../bin')
fnames = fs.readdirSync binDir

pkg = require '../package.json'
pkg.bin ?= {}

for fname in fnames
  extname = path.extname fname
  continue unless extname is '.js'

  fpath = path.resolve binDir, fname
  sname = fname.slice(0, 0 - extname.length)
  spath = path.resolve binDir, sname

  # prepend hashbang to the beginning of each script in ./bin
  file = fs.readFileSync fpath, 'utf8'
  fs.writeFileSync spath, hashbang + file

  # remove js file
  fs.unlinkSync fpath

  # make script executable
  fs.chmodSync spath, 0o711

  # add all scripts to package.json
  pkg.bin[sname] = "./bin/#{sname}"

fs.writeFileSync path.resolve(__dirname, '../package.json'), JSON.stringify(pkg, null, '  ')
