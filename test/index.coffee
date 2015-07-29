vows = require 'vows'
assert = require 'assert'
wintersmith = require 'wintersmith'
plugin = require '../index.js'

# this test currently just tests for generic wintersmith setup
# todo: write tests specific for the NodeSassPlugin
suite = vows.describe 'NodeSassPlugin'
suite.addBatch(
  'wintersmith environment':
    topic: -> wintersmith './example/config.json'
    'loaded ok': (env) ->
      assert.instanceOf env, wintersmith.Environment
    'contents':
      topic: (env) -> env.load @callback
      'loaded ok': (result) ->
        assert.instanceOf result.contents, wintersmith.ContentTree
      'has plugin instances': (result) ->
        assert.instanceOf result.contents['hello.txt'], wintersmith.ContentPlugin
        assert.instanceOf result.contents['main.scss'], wintersmith.ContentPlugin
        assert.instanceOf result.contents['template.sass'], wintersmith.ContentPlugin
        assert.isFunction result.contents['template.sass'].__env.plugins.NodeSassPlugin
        assert.isArray result.contents._.styles
        assert.isArray result.contents._.pages

      'it has the index jade': (result) ->
        for item in result.contents._.pages
          assert.equal item.metadata.template, 'index.jade'
      'has the main.scss': (result) ->
        assert.equal result.contents._.styles[0]._filename.relative, 'main.scss'
      'has the template.sass': (result) ->
        assert.equal result.contents._.styles[1]._filename.relative, 'template.sass'
).run()