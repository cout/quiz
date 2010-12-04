require 'quiz/multiple_choice_question'

module Quiz

class MultipleChoiceQuestionGenerator
  def initialize(choice, n=4)
    @choice = choice
    @n = n
    @definitions = choice.definitions.to_a
  end

  def generate_question
    choices = self.pick_choices(@definitions)
    idx = choices.index(@choice)

    return MultipleChoiceQuestion.new(self, choices, idx)
  end

  def pick_choices(definitions)
    choices = [ @choice ]

    defs = @definitions.shuffle
    defs.each do |defn|
      next if choices.find { |d| d =~ defn }
      break if choices.size == @n
      choices << defn
    end

    return choices.shuffle
  end
end

class MultipleChoiceQuiz < Quiz
  def initialize(frontend, *definitions)
    generators = create_generators(*definitions)

    super(frontend, *generators)
  end

  def create_generators(*definitions_set)
    generators = []
    definitions_set.each do |definitions|
      definitions.each do |definition|
        generators << MultipleChoiceQuestionGenerator.new(definition)
      end
    end
    return generators
  end
end

end

