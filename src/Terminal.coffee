readline = require 'readline'

Message = require '../models/Message'

class Terminal

	constructor: (@messageList) ->
		@rl = readline.createInterface {
			input: process.stdin
			output: process.stdout
			prompt: ''
		}

	run: ->
		@rl.prompt()

		@rl.on 'line', (line) ->
			@messageList.push new Message line
			return

		@rl.on 'close', ->
			console.log 'saindo...'
			process.exit 0
			return
