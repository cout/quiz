require 'quiz/multiple_choice_question'

module Quiz

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
    choices = self.pick_choices(definitions, n)
    correct_choice = rand(choices.size)

    return MultipleChoiceQuestion.new(choices, correct_choice)
  end

  def pick_definition_set
    idx = rand(@definitions.length)
    definitions = @definitions[idx]
    return definitions
  end

  def pick_choices(definitions, n=4)
    choices = []
    defs = definitions.shuffle
    defs.each do |term, defn|
      next if choices.find { |t, d| t == term or d == defn }
      break if choices.size == n
      choices << defn
    end
    return choices
  end
end

end

