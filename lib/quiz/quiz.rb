module Quiz

class Quiz
  def initialize(frontend)
    @frontend = frontend
  end

  def got_response(question, response)
    validate_response(question, response)
  end

  def validate_response(question, response)
    if response == question.correct_response then
      correct_response(question, response)
    else
      incorrect_response(question, response)
    end
  end

  def correct_response(question, response)
    @frontend.correct_response(question)
    record_response(question, response, true)
  end

  def incorrect_response(question, response)
    @frontend.incorrect_response(question)
    record_response(question, response, false)
  end

  def record_response(question, response, was_correct)
  end

  def ask
    raise NotImplementedError("ask() not implemented")
  end
end

end

