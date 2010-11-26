module Quiz

class Quiz
  def initialize(frontend)
    @frontend = frontend
  end

  def got_response(question, answer)
    validate_response(question, answer)
  end

  def validate_response(question, answer)
    if answer == question.answer then
      correct_response(question, answer)
    else
      incorrect_response(question, answer)
    end
  end

  def correct_response(question, answer)
    @frontend.correct_answer(question)
    record_response(question, answer, true)
  end

  def incorrect_response(question, answer)
    @frontend.incorrect_answer(question)
    record_response(question, answer, false)
  end

  def record_response(question, answer, was_correct)
  end

  def ask
    raise NotImplementedError("ask() not implemented")
  end
end

end

