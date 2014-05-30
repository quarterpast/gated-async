gated-async = require './index.js'

export
	'gated-async':
		'should prevent function running in parallel': ->
			running = false
			fn = gated-async (cb)->
				console.assert running is false
				running := true
				process.next-tick ->
					cb!
					running := false

			fn!
			fn!
			fn!


