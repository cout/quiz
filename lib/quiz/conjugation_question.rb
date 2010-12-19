require 'quiz/multiple_choice_question'

module Quiz

class ConjugationQuestion < MultipleChoiceQuestion
end

class ConjugationQuestion::Generator < MultipleChoiceQuestion::Generator
  Question = ConjugationQuestion

  def initialize(choice, n=4)
    super(n)
    @choice = choice
    @conjugations = choice.conjugations
  end

  def pick_choices
    return @choice, pick_choices_from(@conjugations.by_verb(@choice.verb))
  end
end

end
