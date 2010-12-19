require 'quiz/question'

module Quiz

class MultipleChoiceQuestion < Question
  attr_reader :generator
  attr_reader :choices
  attr_reader :correct_choice_idx

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
    return "* #{choices[correct_choice_idx].as_question}\n"
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
    t = format_term(choice.as_choice, opt.length)
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

class MultipleChoiceQuestion::Generator < Question::Generator
  Question = MultipleChoiceQuestion

  def initialize(n=4)
    @n = n
  end

  def generate_question
    correct_choice, choices = self.pick_choices()
    choices << correct_choice
    choices.shuffle!
    idx = choices.index(correct_choice)

    return self.class::Question.new(self, choices, idx)
  end

  def pick_choices
    raise NotImplementedError
  end

  def pick_choices_from(all_choices, n=@n)
    choices = [ ]
    rand_choices = all_choices.shuffle
    rand_choices.each do |choice|
      next if choices.find { |c| c =~ choice }
      break if choices.size == n
      choices << choice
    end

    return choices.shuffle
  end

  def self.create_generators(*choices_set)
    generators = []
    choices_set.each do |choices|
      choices.each do |choice|
        generators << self.new(choice)
      end
    end
    return generators
  end
end

end
