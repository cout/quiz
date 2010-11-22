require 'wx'

require 'quiz/multiple_choice_quiz'

module Quiz

class WxFrontend < Wx::App
  def initialize(*set)
    super()
    @set = set
  end

  def on_init
    @frame = Wx::Frame.new(nil, :title => "Quiz")
    @question = Wx::StaticText.new(@frame, :label => "")
    @frame.show

    @quiz = MultipleChoiceQuiz.new(self, *@set)
    next_question()

    return true
  end

  def next_question
    question = @quiz.ask()
    show_question(question)
  end

  def show_question(question)
    @question.set_label(question.to_s)
  end

  def get_response
    # @outfile.print "? "
    # @outfile.flush
    # answer = @infile.gets
    # answer.chomp!
    # return answer
  end

  def correct_answer(question)
    puts "!!! Correct !!!"
    puts
  end

  def incorrect_answer(question)
    puts "No, the correct answer was #{question.answer}"
    puts
  end
end

end

