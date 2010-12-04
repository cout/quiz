require 'quiz/multiple_choice_question'
require 'quiz/stats'
require 'quiz/encouragement'

require 'set'

module Quiz

class MultipleChoiceQuestionGenerator
  def initialize(choice)
    @choice = choice
    @definitions = choice.definitions.to_a
  end

  def generate_question(n=4)
    choices = self.pick_choices(@definitions, n)
    idx = choices.index(@choice)

    return MultipleChoiceQuestion.new(self, choices, idx)
  end

  def pick_choices(definitions, n)
    choices = [ @choice ]

    defs = @definitions.shuffle
    defs.each do |defn|
      next if choices.find { |d| d =~ defn }
      break if choices.size == n
      choices << defn
    end

    return choices.shuffle
  end

end

class MultipleChoiceQuiz < Quiz
  def initialize(frontend, *definitions)
    super(frontend)

    @generators = []
    @ask_more = Set.new
    @stats = {}

    load_definitions(*definitions)
  end

  def load_definitions(*definitions_set)
    definitions_set.each do |definitions|
      definitions.each do |definition|
        @generators << MultipleChoiceQuestionGenerator.new(definition)
      end
    end
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

