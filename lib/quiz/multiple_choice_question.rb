require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  attr_reader :generator
  attr_reader :choices
  attr_reader :correct_choice
  attr_reader :correct_choice_idx

  def initialize(generator, choices, correct_choice_idx)
    @generator = generator
    @choices = choices
    @correct_choice_idx = correct_choice_idx
    @correct_choice = choices[correct_choice_idx]

    question = self.format_question(choices, correct_choice_idx)
    question << self.format_choices(choices)
    correct_response = self.multi(correct_choice_idx)

    super(question, correct_response)
  end

  def format_question(choices, correct_choice)
    return "* #{choices[correct_choice].definition}\n"
  end

  def format_choices(choices)
    str = ""
    choices.each_with_index do |choice, idx|
      str << format_choice(idx, choice) << "\n"
    end
    return str
  end

  def format_choice(idx, choice)
    opt = "#{multi(idx)}. "
    t = format_term(choice.term, opt.length)
    return "#{opt}#{t}"
  end

  def format_term(term, l)
    div = "\n" + (" " * l)
    return term.gsub(/\n/m, div)
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end
end

end
