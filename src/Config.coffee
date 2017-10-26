fs = require 'fs'

class Config

	constructor: ->
		buffer = fs.readFileSync './config.txt'
		strConfig = (String) buffer
		configArray = strConfig.split '\n'

		nextMachineInfo = configArray[0].split ':'
		@nextMachineIP = nextMachineInfo[0]
		@nextMachinePort = nextMachineInfo[1]
		@myName = configArray[1]
		@sleepTime = (configArray[2] * 1000)
		@hasToken = (configArray[3] is '1234')



module.exports = Config
