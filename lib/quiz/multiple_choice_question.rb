require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  def initialize(choices, correct_choice)
    question = self.format_question(choices, correct_choice)
    question << self.format_choices(choices)

    super(question, self.multi(correct_choice))
  end

  def format_question(choices, correct_choice)
    return "* #{choices[correct_choice].term}\n"
  end

  def format_choices(choices)
    str = ""
    choices.each_with_index do |choice, idx|
      str << format_choice(idx, choice)
    end
    return str
  end

  def format_choice(idx, choice)
    return "#{multi(idx)}. #{format_definition(choice.definition)}\n"
  end

  def format_definition(definition)
    return definition.gsub(/\n/m, "\n   ")
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end
end

end
