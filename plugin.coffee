path = require 'path'
sass = require 'node-sass'
fs = require 'fs'

module.exports = (wintersmith, callback) ->

  class NodeSassPlugin extends wintersmith.ContentPlugin

    constructor: (@_filename) ->

    getFilename: ->
      @_filename.relative.replace /sass|scss$/g, 'css'

    getView: ->
      return (wintersmith, locals, contents, templates, callback) =>
        if path.basename(@_filename.full).charAt(0) == '_'
          callback null
        else
          config = wintersmith.config['node-sass'] or {}
          # temporary hack to prevent node memory issues with sourceComments + wintersmith 'build'
          unless wintersmith.mode is 'preview'
            sourceComments = false
          else
            sourceComments = config.sourceComments  
          sass.render
            file: @_filename.full
            sourceComments: sourceComments            
            success: (css) -> 
              callback null, new Buffer css
            error: (err) ->
              callback new Error err.message + ' on line ' + err.line + ' in ' + err.file

  NodeSassPlugin.fromFile = (filename, callback) ->
    fs.readFile filename.full, (error, buffer) ->
      if error
        callback error
      else
        callback null, new NodeSassPlugin filename, buffer.toString()


  wintersmith.registerContentPlugin 'styles', '**/*.*(scss|sass)', NodeSassPlugin
  callback()
