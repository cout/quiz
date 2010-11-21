require 'quiz'
require 'quiz/frontend/cui'

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

definitions = [ ]
ARGV.each do |filename|
  definitions << Definitions.load(filename)
end

frontend = CuiFrontend.new
quiz = MultipleChoiceQuiz.new(frontend, *definitions)
quiz.go

