require 'quiz/question'

class MultipleChoiceQuiz < Quiz
  def initialize(*definitions)
    @definitions = []
    definitions.each do |d|
      @definitions << d.to_a
    end
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end

  def ask(n=4)
    idx = rand(@definitions.length)
    definitions = @definitions[idx]

    d = definitions.shuffle
    choices = d.take(n)
    correct_choice = rand(n)

    question = self.format_question(choices, correct_choice)
    question << self.format_choices(choices, n)

    return Question.new(question, multi(correct_choice))
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
end

