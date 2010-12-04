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
    question = @quiz.next_question()
    show_question(question)
  end

  def show_question(question)
    @question.set_label(question.to_s)
  end

  def get_response
    # @outfile.print "? "
    # @outfile.flush
    # response = @infile.gets
    # response.chomp!
    # return response
  end

  def correct_response(question)
    puts "!!! Correct !!!"
    puts
  end

  def incorrect_response(question)
    puts "No, the correct response was #{question.correct_response}"
    puts
  end

  def encourage(encouragement)
    puts encouragement
  end
end

end

