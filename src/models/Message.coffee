class Message

	# CONSTANTES
	@TOKEN_TYPE = '1234'
	@OK = 'OK'
	@ERROR = 'erro'
	@NOT_RECEIVE = 'naocopiado'

	constructor: (msg) ->
		msgArray = msg.split ':'
		@ctrl = msgArray[0]
		@cameFrom = msgArray[1]
		@goTo = msgArray[2]
		@text = msgArray[3]

	resend: ->
		@ctrl = @NOT_RECEIVE
		"#{@ctrl};#{@cameFrom};#{@goTo};#{@text}"

	isToken: (msg) ->
		msg == @TOKEN_TYPE

	isForMe: (myName) ->
		myName is @goTo

	isFromMe: (myName) ->
		myName is @cameFrom

module.exports = Message
