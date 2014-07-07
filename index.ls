module.exports = (fn, opts = {})->
	running = false
	queue   = []

	function out(...args)
		if running
			queue.push [run, args]
		else
			run ...args

		if opts.timeout?
			timeout = set-timeout dequeue, that

		function run(...args)
			running := true
			fn ...args, dequeue

		function dequeue
			if timeout?
				clear-timeout that

			if queue.shift!
				<- process.next-tick
				[f, a] = that
				f ...a

			running := false
	
	out.cancel = ->
		running := false
		queue   := []
	out
