require 'quiz/multiple_choice_question'

module Quiz

class MultipleChoiceQuiz < Quiz
  def initialize(frontend, *definitions)
    generators = create_generators(*definitions)

    super(frontend, *generators)
  end

  def create_generators(*definitions_set)
    generators = []
    definitions_set.each do |definitions|
      definitions.each do |definition|
        generators << MultipleChoiceQuestion::Generator.new(definition)
      end
    end
    return generators
  end
end

end

