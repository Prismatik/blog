fs = require 'fs'
path = require 'path'
_ = require 'underscore'
#jade = require 'jade'

module.exports = (env, callback) ->
  defaults =
    template: 'author_page.jade'
    subdir: 'authors'

  options = env.config.authorator or {}
  for k of defaults
    options[k] ?= defaults[k]

  class Authorise extends env.ContentPlugin
    constructor: (@filepath, text) ->
      @authorName = path.basename @filepath.relative, '.json'
      @authorKey = @authorName + '.json'

    getFilename: ->
      arr = @filepath.relative.split(path.sep)
      arr.pop()
      arr.push path.basename(@filepath.relative, '.json'), 'index.html'
      name = arr.join(path.sep)
      return name

    getView: => (env, locals, contents, templates, cb) =>
      localLocals = _.clone locals
      localLocals.authorKey = @authorKey
      cb null, new Buffer(templates[options.template].fn localLocals)

  Authorise.fromFile = (filepath, cb) ->
    fs.readFile filepath.full, (err, text) ->
      plugin = new Authorise filepath, text.toString() if (!err)
      cb err, plugin

  env.registerContentPlugin 'authors', 'authors/*', Authorise

  env.registerGenerator 'authors', (contents, cb) ->
    for authorName, author of contents.authors
      data = fs.readFileSync author.filepath.full
      contents.authors[authorName].metadata = JSON.parse data
    return cb()

    env.locals.contents ?= {}
    env.locals.contents.authors ?= {}
    env.locals.contents.authors[path.basename(filepath, '.json')] = JSON.parse text
  callback()

