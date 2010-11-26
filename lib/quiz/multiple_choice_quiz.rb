require 'quiz/multiple_choice_question'
require 'quiz/stats'

require 'set'

module Quiz

class MultipleChoiceQuiz < Quiz
  def initialize(frontend, *definitions)
    super(frontend)

    @definitions = []
    @ask_more = Set.new
    @stats = {}

    load_definitions(*definitions)
  end

  def load_definitions(*definitions)
    definitions.each do |d|
      @definitions << d.to_a
    end
  end

  def ask(n=4)
    # TODO: if a particular set has fewer questions, those questions
    # will be presented more often than those from sets with more
    # questions

    definitions = self.pick_definition_set()
    choices = self.pick_choices(definitions, n)
    correct_choice = rand(choices.size)

    return MultipleChoiceQuestion.new(choices, correct_choice)
  end

  def pick_definition_set
    idx = rand(@definitions.length)
    definitions = @definitions[idx]
    return definitions
  end

  def pick_choices(definitions, n=4)
    choices = []

    if rand(2) == 0 and @ask_more.length > 0 then
      ask_more = @ask_more.to_a.shuffle
      choice = ask_more[0]
      choices << choice
      definitions = choice.definitions.to_a
      # TODO: this will get the definition into the list, but it won't
      # necessarily be the one that is picked to be the right answer
    end

    defs = definitions.shuffle
    defs.each do |defn|
      next if choices.find { |d| d =~ defn }
      break if choices.size == n
      choices << defn
    end

    return choices
  end

  def record_response(question, answer, was_correct)
    choice = question.correct_choice
    stats = (@stats[choice] ||= Stats.new(choice))

    if was_correct then
      stats.record_correct_response()
    else
      stats.record_incorrect_response()
    end

    if stats.percent_correct > 0.50 then
      @ask_more.delete(choice)
    else
      @ask_more.add(choice)
    end

    # puts "You've gotten this correct #{stats.correct}/#{stats.total} times (#{stats.percent_correct * 100}%)"
    # puts
  end
end

end

