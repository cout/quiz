module Quiz

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
        @frontend.correct_answer(question)
      else
        @frontend.incorrect_answer(question)
      end
    end
  end
end

end

