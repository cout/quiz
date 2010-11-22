require 'quiz'
require 'quiz/frontend/wx'

if __FILE__ == $0 then

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

set = Quiz::Definitions.load_set(*ARGV)
frontend = Quiz::WxFrontend.new
quiz = Quiz::MultipleChoiceQuiz.new(frontend, *set)
frontend.main_loop

end

