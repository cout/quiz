module Quiz

# A +Question+ has:
# - a question
# - a correct response to the question
#
# The question itself is a string, possibly composed of multiple lines
# of text.  In the case of a multiple choice question, it contains all
# the multiple choices.
#
# The correct response is also a string.  In the case of a multiple
# choice question, it is the letter of the correct response.
#
class Question
  attr_reader :question
  attr_reader :correct_response

  def initialize(question, correct_response)
    @question = question
    @correct_response = correct_response
  end

  def to_s
    return question.to_s
  end
end

# A +Question+ +Generator+ generates a +Question+.  There is one
# +Generator+ per correct answer.  In the case of a multiple choice
# question, each +Generator+ knows what other choices make sense (e.g.
# it wouldn't make sense to present a biology question with spanish
# answers, even if both question sets are loaded into the same quiz).
class Question::Generator
end

end

