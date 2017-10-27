Terminal = require './Terminal'
Network = require './Network'
Config = require './Config'

class App

	constructor: (@name)->
		@config = new Config()
		@network = new Network()
		@terminal = new Terminal()
		@queue = []

	run: ->
		@network
			.setConfig @config
			.setQueue @queue
			.run()
		@terminal
			.setQueue @queue
			.setHeaderName @config.myName
			.run()





app = new App()
app.run()
