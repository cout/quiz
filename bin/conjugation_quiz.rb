require 'quiz/conjugations'
require 'quiz/conjugation_question'
require 'quiz/quiz'
require 'quiz/frontend/cui'

if __FILE__ == $0 then

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

set = Quiz::Conjugations.load_set(*ARGV)
generators = Quiz::ConjugationQuestion::Generator.create_generators(*set)
frontend = Quiz::CuiFrontend.new
quiz = Quiz::Quiz.new(frontend, *generators)
frontend.main_loop(quiz)

end

