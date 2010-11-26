require 'quiz/multiple_choice_question'
require 'quiz/stats'

require 'set'

module Quiz

class MultipleChoiceQuestionGenerator
  def initialize(choice)
    @choice = choice
    @definitions = choice.definitions.to_a
  end

  def generate_question(n=4)
    choices = self.pick_choices(@definitions, n)
    correct_choice = choices.index(@choice)

    return MultipleChoiceQuestion.new(self, choices, correct_choice)
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

  def record_response(question, answer, was_correct)
    choice = question.correct_choice
    generator = question.generator

    stats = (@stats[choice] ||= Stats.new(choice))
    stats.record_response(was_correct)

    if stats.percent_correct > 0.50 then
      @ask_more.delete(generator)
    else
      @ask_more.add(generator)
    end

    # puts "You've gotten this correct #{stats.correct}/#{stats.total} times (#{stats.percent_correct * 100}%)"
    # puts
  end
end

end

