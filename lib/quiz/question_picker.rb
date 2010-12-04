require 'set'

module Quiz

class QuestionPicker
  def initialize(*generators)
    @generators = generators
    @ask_more = Set.new
  end

  def pick_question
    generator = self.pick_question_generator()
    question = generator.generate_question()
    return question
  end

  def pick_question_generator
    if rand(2) == 0 and @ask_more.length > 0 then
      ask_more = @ask_more.to_a.shuffle
      return ask_more[0]
    else
      idx = rand(@generators.length)
      return @generators[idx]
    end
  end

  def record_response(question, response, response_stats, was_correct)
    if response_stats.percent_correct > 0.50 then
      @ask_more.delete(question.generator)
    else
      @ask_more.add(question.generator)
    end
  end
end

end
