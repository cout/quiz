require 'quiz'
require 'quiz/frontend/cui'

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

set = Definitions.load_set(*ARGV)
frontend = CuiFrontend.new
quiz = MultipleChoiceQuiz.new(frontend, *set)
quiz.go

