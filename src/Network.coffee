dgram = require 'dgram'

Message = require './Message'

class Network

	constructor: ->
		@socket = dgram.createSocket 'udp4'
		@sendMessage = false

	setConfig: (@config) -> @

	setQueue: (@queue) -> @

	run: ->
		@socket.on 'listening', ->
			console.log 'Entrando na rede...\n'


		@socket.on 'message', (buffer, info) =>
			strBuffer = (String) buffer
			msg = new Message strBuffer

			if msg.isToken()
				console.log 'Token recebido...\n'
				console.log 'Verificando lista de mensagens...'
				queueSize = @queue.length
				if queueSize > 1
					choosen = @queue.shift
					console.log "Enviando mensagem : < #{choosen} > \n"
					sendToNext choosen
				else
					console.log 'Lista Vazia...\n'
					sendToken()

			else if msg.isForMe(@config.myname)
				console.log 'Mensagem...\n'
				console.log "From #{msg.origin}: #{msg.text}\n"
				err = randomError()
				console.log "Verificando mensagem... (Erro: #{err})\n"
				if err then msg.setError() else msg.setRead()
				sendToNext(msg)

			else if msg.isFromMe(@config.myName)
				console.log 'Mensagem deu uma volta completa...\n'
				if msg.hasError()
					console.log 'Mensagem possui erro...\n'
					if @sendMessage
						console.log 'Mensagem já deu uma volta, passando token...\n'
						sendToken()
					else
						console.log 'Tentando novamente...\n'
						@sendMessage = true
						msg.clearError()
						sendToNext(msg)



		@socket.bind 6666


		return @

	randomError: ->
		rd = Math.floor (Math.random() * 10) + 1
		if rd > 2 then false else true

	sendToNext: (msg) ->
		console.log "Enviando mensagem para #{@config.nextMachine}\n"
		@socket.send msg.toString(), 6666, @config.nextMachine

	sendToken: ->
		console.log 'Enviando Token...\n'
		@sendMessage = false
		@socket.send '1234', 6666, @config.nextMachine

module.exports = Network
