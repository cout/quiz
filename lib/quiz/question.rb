module Quiz

class Question
  attr_reader :question
  attr_reader :correct_response

  def initialize(question, correct_response)
    @question = question
    @correct_response = correct_response
  end

  def to_s
    return question.to_s
  end
end

end

