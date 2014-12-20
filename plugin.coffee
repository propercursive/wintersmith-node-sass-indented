child_process = require 'child_process'
path = require 'path'
sass = require 'node-sass'
fs = require 'fs'

module.exports = (wintersmith, callback) ->
  options   = wintersmith.config['node-sass'] or {}
  exec_opts = options.exec_opts or {}

  class NodeSassPlugin extends wintersmith.ContentPlugin

    constructor: (@_filename) ->

    getFilename: ->
      @_filename.relative.replace /sass|scss$/g, 'css'

    getView: ->
      return (env, locals, contents, templates, callback) =>
        if path.basename(@_filename.full).charAt(0) == '_'
          callback null
        else
          command = [@_filename.full]

          onComplete = (error, stdout, stderr) ->
            if error
              callback error
            else
              callback null, new Buffer stdout

          c = child_process.execFile 'sass', command, exec_opts, onComplete
        
  NodeSassPlugin.fromFile = (filename, callback) ->
    fs.readFile filename.full, (error, buffer) ->
      if error
        callback error
      else
        callback null, new NodeSassPlugin filename, buffer.toString()


  wintersmith.registerContentPlugin 'styles', '**/*.*(scss|sass)', NodeSassPlugin
  callback()