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

		'should move on after a timeout': (done)->
			once = false
			start = Date.now!
			fn = gated-async do
				(cb)->
					if once
						console.assert Date.now! - start < 10000
						cb!
						done!
					else
						set-timeout cb, 10000
						once := true

				timeout: 1000
				
			fn!
			fn!
