url = ARGV[0]
REGEX_PATTERN = /^https:\/\/.*ngrok.io$/
puts "To nie link. Podaj ponownie" if ( REGEX_PATTERN =~ url).nil?
exit(-1)