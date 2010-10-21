require 'quiz/question'

class MultipleChoiceQuiz < Quiz
  def initialize(definitions)
    @definitions = definitions.to_a
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end

  def ask(n=4)
    d = @definitions.shuffle
    choices = d.take(n)
    correct_choice_idx = rand(n)
    question = "* #{choices[correct_choice_idx][1]}\n"
    for i in 0...n do
      question << "#{multi(i)}. #{choices[i][0]}\n"
    end
    return Question.new(question, multi(correct_choice_idx))
  end
end

