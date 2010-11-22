require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  def initialize(choices, correct_choice, n=4)
    question = self.format_question(choices, correct_choice)
    question << self.format_choices(choices, n)

    super(question, self.multi(correct_choice))
  end

  def format_question(choices, correct_choice)
    return "* #{choices[correct_choice][1]}\n"
  end

  def format_choices(choices, n=4)
    str = ""
    for i in 0...n do
      next if not choices[i]
      str << "#{multi(i)}. #{choices[i][0]}\n"
    end
    return str
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end
end

end
