class Quiz
  def initialize(frontend)
    @frontend = frontend
  end

  def go(file=$stdin)
    loop do
      question = ask()
      @frontend.show_question(question)

      answer = @frontend.get_response()
      if answer == question.answer then
        puts "Correct"
      else
        puts "No, the correct answer was #{question.answer}"
      end
      puts
    end
  end
end

