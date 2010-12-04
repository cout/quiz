require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  attr_reader :generator
  attr_reader :choices

  def initialize(generator, choices, correct_choice_idx)
    @generator = generator
    @choices = choices
    @correct_choice_idx = correct_choice_idx

    question = self.format_question(choices, correct_choice_idx)
    question << self.format_choices(choices)
    correct_response = self.multi(correct_choice_idx)

    super(question, correct_response)
  end

  def format_question(choices, correct_choice_idx)
    return "* #{choices[correct_choice_idx].definition}\n"
  end

  def format_choices(choices)
    str = ""
    choices.each_with_index do |choice, idx|
      str << format_choice(idx, choice) << "\n"
    end
    return str
  end

  def format_choice(idx, choice)
    opt = "#{multi(idx)}. "
    t = format_term(choice.term, opt.length)
    return "#{opt}#{t}"
  end

  def format_term(term, l)
    div = "\n" + (" " * l)
    return term.gsub(/\n/m, div)
  end

  def multi(i)
    return "abcdefghijklmnopqrstuvwxyz"[i].chr
  end
end

class MultipleChoiceQuestion::Generator
  def initialize(choice, n=4)
    @choice = choice
    @n = n
    @definitions = choice.definitions.to_a
  end

  def generate_question
    choices = self.pick_choices(@definitions)
    idx = choices.index(@choice)

    return MultipleChoiceQuestion.new(self, choices, idx)
  end

  def pick_choices(definitions)
    choices = [ @choice ]

    defs = @definitions.shuffle
    defs.each do |defn|
      next if choices.find { |d| d =~ defn }
      break if choices.size == @n
      choices << defn
    end

    return choices.shuffle
  end

  def self.create_generators(*definitions_set)
    generators = []
    definitions_set.each do |definitions|
      definitions.each do |definition|
        generators << MultipleChoiceQuestion::Generator.new(definition)
      end
    end
    return generators
  end
end

end
