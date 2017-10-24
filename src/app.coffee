
Connection = require './Connection'
Terminal = require './Terminal'
Message = require './Message'

class App

	constructor: ->
		@messageList = []
		@connection = new Connection()
		@terminal = new Terminal()

	run: ->
		connection.run()
		terminal.run()



app = new App
app.run()
