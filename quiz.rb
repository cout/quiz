class Definitions
  def initialize(h)
    @h = h
    @a = h.to_a
  end

  def self.load(filename)
    h = { }
    definition = nil
    File.open(filename) do |file|
      file.each_line do |line|
        line.chomp!
        case line
        when /^\s*$/, /^#/
          # comment
        when /^(.*?)\s+-\s+(.*)/
          # definition
          term = $1
          definition = $2
          h[term] = definition
        else
          definition << ' ' if definition[-1] == ?.
          definition << ' ' << line
        end
      end
    end
    return self.new(h)
  end

  def to_a
    return @a
  end
end

class Quiz
  def go
    loop do
      question = ask()
      puts "================================="
      puts question
      puts "================================="
      print "? "
      $stdout.flush
      answer = gets
      answer.chomp!
      if answer == question.answer then
        puts "Correct"
      else
        puts "No, the correct answer was #{question.answer}"
      end
      puts
    end
  end
end

class Question
  attr_reader :question
  attr_reader :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def to_s
    return question.to_s
  end
end

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

#definitions = Definitions.load('test.txt')
definitions = Definitions.load('biology_ch_9.txt')
quiz = MultipleChoiceQuiz.new(definitions)
quiz.go

