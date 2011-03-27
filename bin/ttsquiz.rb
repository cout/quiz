require 'quiz/definitions'
require 'quiz/tts_question'
require 'quiz/quiz'
require 'quiz/frontend/tts'

if __FILE__ == $0 then

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

set = Quiz::Definitions.load_set(*ARGV)
generators = Quiz::TtsQuestion::Generator.create_generators(*set)
frontend = Quiz::TtsFrontend.new
quiz = Quiz::Quiz.new(frontend, *generators)
frontend.main_loop(quiz)

end

