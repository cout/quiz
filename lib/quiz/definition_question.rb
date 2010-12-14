require 'quiz/multiple_choice_question'

module Quiz

class DefinitionQuestion < MultipleChoiceQuestion
end

class DefinitionQuestion::Generator < MultipleChoiceQuestion::Generator
  def initialize(choice, n=4)
    @choice = choice
    @n = n
    @definitions = choice.definitions.to_a
  end

  def pick_choices
    return pick_choices_from(@definitions)
  end
end

end

