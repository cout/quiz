require 'quiz/question'
require 'quiz/multiple_choice_question'

module Quiz

class ConjugationQuestion < MultipleChoiceQuestion
end

class ConjugationQuestion::Generator < MultipleChoiceQuestion::Generator
  Question = ConjugationQuestion

  def initialize(choice, n=4)
    @choice = choice
    @n = n
    @conjugations = choice.conjugations
  end

  def pick_choices
    return pick_choices_from(@conjugations.by_verb(@choice.verb))
  end
end

end
