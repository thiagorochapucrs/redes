fs = require 'fs'

class Config

	constructor: ->
		buffer = fs.readFileSync './config.txt'
		strConfig = (String) buffer
		configArray = strConfig.split '\n'

		@nextMachine = configArray[0]
		@myName = configArray[1]
		@sleepTime = configArray[2]


module.exports = Config
