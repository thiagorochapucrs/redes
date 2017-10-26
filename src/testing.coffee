dgram = require 'dgram'


socket = dgram.createSocket 'udp4'


socket.on 'listening', ->
	console.log 'hit the music!'


socket.send '1234', 6666, '192.168.1.121'
