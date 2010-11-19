require 'quiz'

#definitions = Definitions.load('test.txt')
#definitions = Definitions.load('biology_ch_9.txt')
# ARGV.each do |arg|
  # definitions = Definitions.load(arg)
  # end

if not ARGV[0] then
  puts "Usage: #$0 <filename>"
  exit 1
end

definitions = Definitions.load(ARGV[0])
quiz = MultipleChoiceQuiz.new(definitions)
quiz.go

