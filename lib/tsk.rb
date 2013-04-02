require 'tsk/version'
require 'date'
require 'yaml'

module Tsk
    class Main
        def initialize
            @start = "START"
            @stop = "STOP"
            @log_file = File.expand_path('../../storage/log', __FILE__)
            @log = load_log
        end

        def run args
            @args = args
            case @args[0]
            when "start", "sta"
                start @args[1]
            when "stop", "sto"
                stop
            when "status", "st"
                status
            when "report", "r"
                do_pretty = @args[1] == "--pretty" || @args[1] == "-p"
                report do_pretty
            when "clear"
                puts "This will remove all logged time."
                print "Are you sure you want to do this? "
                print "(anything but \"yes\" will cancel) "
                yes_no = $stdin.gets.chomp
                if yes_no == 'yes'
                    print "Wiping log... "
                    File.open(@log_file, 'w+') { |f| f.write('') }
                    print "Done.\n"
                else
                    puts "Your log was not wiped."
                end
            else
                help
            end
        end

        def start name
            name ||= "Unnamed task"
            stop true
            puts "Starting task: #{name}"
            write_to_log @start, name
        end

        def stop silent=false
            if task_running?
                puts "Stopping last task."
                write_to_log @stop
            else
                puts "No task running. Nothing was done." unless silent
            end
        end

        def status
            if task_running?
                puts "Task that is running:\n\t#{get_last_task[:name]}"
            else
                puts "No running task."
            end
        end

        def get_last_task
            if @log.length > 0
                @log[@log.keys.last][-1]
            else
                false
            end
        end

        def task_running?
            if get_last_task
                get_last_task[:action] == @start
            else
                false
            end
        end

        def report pretty=false
            @log.keys.each do |date|
                puts date
                last = {}
                @log[date].each do |entry|
                    if entry[:action] == @start
                        last = entry
                    elsif entry[:action] == @stop
                        d = date.split('-')
                        t = last[:time].split(':')
                        start_t = Time.new(d[0], d[1], d[2], t[0], t[1], t[2]).to_i
                        t = entry[:time].split(':')
                        end_t = Time.new(d[0], d[1], d[2], t[0], t[1], t[2]).to_i
                        puts "\t" + last[:name]
                        puts "\t" + NumberHelper.duration(end_t - start_t)
                        puts
                    end
                end
            end
        end

        def help
            puts "Usage: tsk [start[=<name>]|stop|status|report|clear|help]"
            puts
            puts "\tstart:\tStart a task."
            puts "\tstop:\tStop the currently running task."
            puts "\tstatus:\tDisplay the current task,  if any."
            puts "\treport:\tShows a list of all tasks and time taken for each."
            puts "\tclear:\tClear out the log file. Use with caution."
            puts "\thelp:\tDisplay this help text. Meta."
            puts
            puts "Example:\n\ttsk start \"Doing something\""
        end

        def load_log
            YAML::load_file(@log_file) || Hash.new
        end

        def write_to_log action, task=nil
            time = Time.now
            data = {:action => action, :time => time.strftime('%T'), :name => task}
            date = time.strftime '%F'
            @log[date] ||= []
            @log[date] << data
            File.open(@log_file, 'w+') { |f| f.write(YAML::dump(@log)) }
        end
    end

    class NumberHelper
        def self.duration time
            rest, seconds = time.divmod(60)
            rest, minutes = rest.divmod(60)
            hours = rest
            Time.new(2013, 3, 2, hours, minutes, seconds).strftime('%T')
        end
    end
end
