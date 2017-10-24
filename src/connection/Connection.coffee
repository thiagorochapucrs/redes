Config = require './Config'
Socket = require './Socket'


class Connection
	constructor: (@socket = new Socket(), @config = new Config()) ->


	sendMessageNext: ->
		return

	resendMessage: ->
		return

	readMessage: ->
		return
