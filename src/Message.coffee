class Message

	@TOKEN_TYPE = '1234'
	@OK = 'OK'
	@ERROR = 'erro'
	@NOT_RECEIVE = 'naocopiado'

	constructor: (msg) ->
		aux = msg.split ';'
		@idHeader = aux[0]

		if (aux[1]?) and (@idHeader isnt @TOKEN_TYPE)
			aux = aux[1].split ':'
			@ctrlHeader = aux[0]
			@origin = aux[1]
			@destiny = aux[2]
			@text = aux[3]

		return @

	isToken: ->
		@idHeader is @TOKEN_TYPE

	isForMe: (name) ->
		@destiny is name

	isFromMe: (name) ->
		@origin is name

	hasError: ->
		@ctrlHeader is @ERROR

	clearError: ->
		@ctrlHeader = @NOT_RECEIVE
		@

	setError: ->
		@ctrlHeader = @ERROR
		@

	setRead: ->
		@ctrlHeader = @OK
		@

	toString: ->
		"2345;#{@ctrlHeader}:#{@origin}:#{@destiny}:#{@text}"



module.exports = Message
