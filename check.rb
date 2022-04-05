require 'capybara'
require 'dotenv'
require './functions'
Dotenv.load
$slack_api_id = ENV['SLACK_API_ID']
include Sites


if ARGV.count == 0
  puts 'brak argumentów'
  exit(-1)
elsif ARGV.count > 1
  puts 'za dużo argumentów'
  exit(-2)
end
new_url = ARGV[0]
REGEX_PATTERN = /^https:\/\/.*ngrok.io$/
puts "That is not a link. Try again" if ( REGEX_PATTERN =~ new_url).nil?
exit(-1) if ( REGEX_PATTERN =~ new_url).nil?
session = Capybara::Session.new(:selenium)
action_url = "#{new_url}/api/slack/action"
event_url = "#{new_url}/api/slack/event"
slash_commands_url = "#{new_url}/api/slack/command"
sign_in(session: session)
interactive_message(action_url:action_url, session: session)
0.upto(how_many_commands(session: session) - 1) do |u|
  slash_commands(slash_commands_url: slash_commands_url, session: session, number_for_command: u)
end
ouath(oauth_url: new_url, session: session)
event_subscription(session: session, event_url:event_url)
exit(0)
