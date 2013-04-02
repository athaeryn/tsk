# Tsk

This is a simple task tracker that I wrote to work the way I needed it to. You
may like it, you may not.

## Installation

    $ gem install tsk

## Usage

tsk [start[=<name>]|stop|status|report|clear|help]

	start:	Start a task.
	stop:	Stop the currently running task.
	status:	Display the current task,  if any.
	report:	Shows a list of all tasks and time taken for each.
	clear:	Clear out the log file. Use with caution.
	help:	Display this help text. Meta.

Example:
	tsk start "Doing something"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
