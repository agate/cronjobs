# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require 'yaml'

BASE_DIR = File.expand_path('../..', __FILE__)
ENABLED_TASKS = YAML.load_file("#{BASE_DIR}/enabled_tasks")

every 3.hours do
  ENABLED_TASKS.each do |site|
    dir = "#{BASE_DIR}/tasks/#{site}"
    log = "#{BASE_DIR}/tasks/#{site}/crontab.log"
    command "#{dir}/checkin >> #{log} 2>&1"
  end
end
