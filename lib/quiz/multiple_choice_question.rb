require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  def initialize(choices, correct_choice)
    question = self.format_question(choices, correct_choice)
    question << self.format_choices(choices)

    super(question, self.multi(correct_choice))
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
