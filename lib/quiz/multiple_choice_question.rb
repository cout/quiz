require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  def initialize(choices, correct_choice)
    question = self.format_question(choices, correct_choice)
    question << self.format_choices(choices)

    super(question, self.multi(correct_choice))
  end

  def format_question(choices, correct_choice)
    return "* #{choices[correct_choice][1]}\n"
  end

  def format_choices(choices)
    str = ""
    choices.each_with_index do |choice, idx|
      s_choice = choice[0].gsub(/\n/m, "\n   ")
      str << "#{multi(idx)}. #{s_choice}\n"
    end
    return str
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end
end

end
