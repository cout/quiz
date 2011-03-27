require 'quiz/question'

module Quiz

class TtsQuestion < Question
  def initialize(choice)
    question = choice.as_question
    answer = choice.as_answer
    super(question, answer)
  end
end

class TtsQuestion::Generator < Question::Generator
  Question = TtsQuestion

  def initialize(choices)
    @choices = choices.to_a
  end

  def generate_question
    choice = @choices.shuffle[0]
    return self.class::Question.new(choice)
  end

  def self.create_generators(*choices_set)
    generators = []
    choices_set.each do |choices|
      generators << self.new(choices)
    end
    return generators
  end
end

end

