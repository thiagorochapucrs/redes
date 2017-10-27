readline = require 'readline'

Message = require './Message'

class Terminal

	constructor: ->
		@rl = readline.createInterface {
			input: process.stdin
			output: process.stdout
			prompt: ''
		}

	setQueue: (@messageList) -> @
	setHeaderName: (name) ->
		@header = "2345;naocopiado:#{name}:"
		@

	run: () ->
		@rl.prompt()

		@rl.on 'line', (line) =>
			line = @header + line
			msg = new Message line
			@messageList.push msg
			return

		@rl.on 'close', ->
			console.log 'saindo...'
			process.exit 0
			return

module.exports = Terminal
