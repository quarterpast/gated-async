module.exports = (fn)->
	running = false
	queue   = []

	(...args)->
		if running
			queue.push [run, args]
		else
			run ...args

		function run(...args)
			running := true
			<- fn ...args
			if queue.shift!
				<- process.next-tick
				[f, a] = that
				f ...a
			running := false
