require 'clipboard'
a = ARGV.to_s.split.join(".").to_s
a[1] = '.'
Clipboard.copy(a[1..a.size-3])