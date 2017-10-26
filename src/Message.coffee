class Message

	constructor: (msg) ->
		aux = msg.split ';'
		@idHeader = aux[0]

		if (aux[1]?) and (@idHeader isnt '1234')
			aux = aux[1].split ':'
			@ctrlHeader = aux[0]
			@origin = aux[1]
			@destiny = aux[2]
			@text = aux[3]

		return @

	isToken: ->
		@idHeader is '1234'

	isForMe: (name) ->
		@destiny is name

	isFromMe: (name) ->
		@origin is name

	hasError: ->
		@ctrlHeader is 'error'

	clearError: ->
		@ctrlHeader = 'naocopiado'
		@

	setError: ->
		@ctrlHeader = 'error'
		@

	setRead: ->
		@ctrlHeader = 'OK'
		@

	toString: ->
		"2345;#{@ctrlHeader}:#{@origin}:#{@destiny}:#{@text}"



module.exports = Message
