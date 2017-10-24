dgram = require 'dgram'
timer = require 'timer'

Message = require './models/Message'

class Socket

	@DEFAULT_PORT = 6666

	constructor: (@config) ->
		@connection = dgram.createSocket 'udp4'

	run: ->
		@connection.on 'listening', ->
			console.log 'Entrando na rede...'


		@connection.on 'message', (buffer, info) ->


		return

	send: (msg, ip) ->
		@connection.send msg, @DEFAULT_PORT, ip
		return


module.exports Socket
