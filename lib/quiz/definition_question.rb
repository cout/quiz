require 'quiz/multiple_choice_question'

module Quiz

class DefinitionQuestion < MultipleChoiceQuestion
end

class DefinitionQuestion::Generator < MultipleChoiceQuestion::Generator
  def initialize(choice, n=4)
    super(n)
    @choice = choice
    @definitions = choice.definitions.to_a
  end

  def pick_choices
    return @choice, pick_choices_from(@definitions)
  end
end

end

