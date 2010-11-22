module Quiz

class Quiz
  def initialize(frontend)
    @frontend = frontend
  end

  def go
    loop do
      question = ask()
      @frontend.ask(question, self)
    end
  end

  def got_response(question, answer)
    validate_response(question, answer)
  end

  def validate_response(question, answer)
    if answer == question.answer then
      @frontend.correct_answer(question)
    else
      @frontend.incorrect_answer(question)
    end
  end

  def ask
    raise NotImplementedError("ask() not implemented")
  end
end

end

