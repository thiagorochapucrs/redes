dgram = require 'dgram'
timer = require 'timers'

Message = require './Message'

class Network

	constructor: ->
		@socket = dgram.createSocket 'udp4'
		@sendMessage = false

	setConfig: (@config) ->
		console.log 'Configuração....'
		console.log 'Nome: ', @config.myName
		console.log 'Máquina a direta: ', @config.nextMachineIP
		console.log 'Porta da aplicação: ', @config.nextMachinePort
		console.log 'Tempo de espera (ms): ', @config.sleepTime
		@

	setQueue: (@queue) -> @

	run: ->
		port = 6666

		@socket.on 'listening', =>
			console.log "Ouvindo porta #{port}..."
			if @config.hasToken
				console.log 'Iniciando com token...'
				console.log 'Verificando lista de mensagens...'
				queueSize = @queue.length
				if queueSize > 1
					choosen = @queue.shift()
					console.log "Enviando mensagem: < #{choosen} > "
					@sendToNext choosen
				else
					console.log 'Lista Vazia...'
					@sendToken()
			else
				console.log 'Não foi inicializado com token...'
			return


		@socket.on 'message', (buffer, info) =>
			console.log 'Recebendo mensagem...'
			console.log "Pacote recebido com o conteudo: " + buffer
			console.log 'Aguardando...'
			timer.setTimeout =>
				@appLogic(buffer)
				return
			, @config.sleepTime
			return

		@socket.bind port



		return @

	randomError: ->
		rd = Math.floor (Math.random() * 10) + 1
		if rd > 5 then false else true

	sendToNext: (msg) ->
		console.log "Enviando pacote para #{@config.nextMachineIP}:#{@config.nextMachinePort}"
		@socket.send msg.toString(), @config.nextMachinePort, @config.nextMachine

	sendToken: ->
		console.log 'Enviando Token...'
		@sendMessage = false
		token = '1234'
		console.log @config.nextMachineIP
		@socket.send token, @config.nextMachinePort, @config.nextMachineIP

	appLogic: (buffer, info) =>
		console.log 'Iniciando lógica da rede...'
		name = @config.myName
		strBuffer = (String) buffer
		msg = new Message strBuffer
		if msg.isToken()
			console.log 'Token recebido...'
			console.log 'Verificando lista de mensagens...'
			queueSize = @queue.length
			console.log "Lista com tamanho #{queueSize}"
			if queueSize >= 1
				choosen = @queue.shift()
				console.log "Enviando mensagem : < #{choosen} > "
				@sendToNext choosen
			else
				console.log 'Lista Vazia...'
				@sendToken()
		else if msg.isFromMe(name)
			console.log 'Mensagem deu uma volta completa...'
			if msg.hasError()
				console.log 'Mensagem possui erro...'
				if @sendMessage
					console.log 'Mensagem já deu uma segunda volta, passando token...'
					@sendToken()
				else
					console.log 'Tentando novamente...'
					@sendMessage = true
					msg.clearError()
					@sendToNext(msg)
			else
				console.log 'Mensagem finalizada...'
				@sendToken()
		else if msg.isForAll()
				console.log 'Mensagem broadcast...'
				console.log "From #{msg.origin}: #{msg.text}"
				@sendToNext(msg)
		else if msg.isForMe(name)
			console.log 'Mensagem...'
			console.log "From #{msg.origin}: #{msg.text}"
			err = @randomError()
			console.log "Verificando mensagem... (Erro: #{err})"
			if err then msg.setError() else msg.setRead()
			@sendToNext(msg)
		else
			console.log 'Não é pra mim....'
			@sendToNext(msg)
		return

module.exports = Network
