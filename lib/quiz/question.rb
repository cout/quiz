module Quiz

class Question
  attr_reader :question
  attr_reader :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def to_s
    return question.to_s
  end
end

end

