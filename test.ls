gated-async = require './index.js'

export
	'gated-async':
		'should prevent function running in parallel': (done)->
			running = false
			count = 0
			fn = gated-async (cb)->
				console.assert running is false
				running := true
				process.next-tick ->
					cb!
					count += 1
					running := false

					if count is 3 then done!

			fn!
			fn!
			fn!


