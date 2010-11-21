require 'quiz/multiple_choice_question'

class MultipleChoiceQuiz < Quiz
  def initialize(frontend, *definitions)
    super(frontend)

    @definitions = []
    load_definitions(*definitions)
  end

  def load_definitions(*definitions)
    definitions.each do |d|
      @definitions << d.to_a
    end
  end

  def ask(n=4)
    definitions = self.pick_definition_set()

    d = definitions.shuffle
    choices = d.take(n)
    correct_choice = rand(n)

    return MultipleChoiceQuestion.new(choices, correct_choice, n)
  end

  def pick_definition_set
    idx = rand(@definitions.length)
    definitions = @definitions[idx]
    return definitions
  end
end

