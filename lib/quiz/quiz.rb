require 'quiz/stats'
require 'quiz/encouragement'

require 'set'

module Quiz

class Quiz
  def initialize(frontend, *generators)
    @frontend = frontend
    @generators = generators
    @ask_more = Set.new
    @stats = {}
  end

  def got_response(question, response)
    validate_response(question, response)
  end

  def validate_response(question, response)
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

  def record_response(question, response, was_correct)
  end

  def ask(n=4)
    # TODO: if a particular set has fewer questions, those questions
    # will be presented more often than those from sets with more
    # questions

    generator = self.pick_question_generator()
    question = generator.generate_question(n)

    return question
  end

  def pick_question_generator()
    if rand(2) == 0 and @ask_more.length > 0 then
      ask_more = @ask_more.to_a.shuffle
      return ask_more[0]
    else
      idx = rand(@generators.length)
      return @generators[idx]
    end
  end

  def record_response(question, response, was_correct)
    generator = question.generator

    stats = (@stats[question.correct_response] ||= Stats.new(question.correct_response))
    stats.record_response(was_correct)

    if stats.percent_correct > 0.50 then
      @ask_more.delete(generator)
    else
      @ask_more.add(generator)
    end

    encouragement = Encouragement.after_response(stats, was_correct)
    puts encouragement
  end
end

end

