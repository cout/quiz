require 'quiz'

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

definitions = [ ]
ARGV.each do |filename|
  definitions << Definitions.load(filename)
end

quiz = MultipleChoiceQuiz.new(*definitions)
quiz.go

