require 'rubygems'
require 'ruby-prof'
require 'word_jumble'

if ARGV.length == 0
  words = ["kittens", "penguins", "lions", "tigers", "leopards", "puppies", "squirrels"]
  width = 20
  height = 20
else
  words = ARGV[2..ARGV.length-1].collect { |a| a.to_s }
  width = ARGV[0].to_i
  height = ARGV[1].to_i
end

wj = nil

result = RubyProf.profile do
  wj = WordJumble.new(width, height, words)
  puts wj
end

printer = RubyProf::GraphPrinter.new(result)
printer.print(STDOUT, 0)