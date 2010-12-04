require 'quiz/encouragement'
require 'quiz/stats'
require 'quiz/question_picker'

module Quiz

class Quiz
  def initialize(frontend, *generators)
    @frontend = frontend
    @question_picker = QuestionPicker.new(*generators)
    @response_stats = Hash.new { |h,response| Stats.new(response) }
  end

  def got_response(question, response)
    if response == question.correct_response then
      correct_response(question, response)
    else
      incorrect_response(question, response)
    end
  end

  def correct_response(question, response)
    @frontend.correct_response(question)
    record_response(question, response, true)
  end

  def incorrect_response(question, response)
    @frontend.incorrect_response(question)
    record_response(question, response, false)
  end

  def next_question
    question = @question_picker.pick_question()
    return question
  end

  def record_response(question, response, was_correct)
    response_stats = @response_stats[question.correct_response]
    response_stats.record_response(was_correct)

    @question_picker.record_response(question, response, response_stats, was_correct)

    encouragement = Encouragement.after_response(response_stats, was_correct)
    @frontend.encourage(encouragement)
  end
end

end

