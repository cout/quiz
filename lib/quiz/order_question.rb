require 'quiz/multiple_choice_question'
require 'quiz/choice'

module Quiz

class OrderQuestion < MultipleChoiceQuestion
  def correct_response
    idx = self.correct_choice_idx()
    correct_choice = self.choices[idx]
    v = correct_choice.values.map { |c| c.to_s }
    s = "#{super()} (#{v.join(', ')})"
  end
end

class OrderQuestion::Choice < ::Quiz::Choice
  include Comparable

  attr_reader :values

  def initialize(values)
    @values = values
  end

  def as_question
    return "Compare:"
  end

  def as_choice
    a = @values.map { |v| v.name }
    s = a.join(' < ')
    return s
  end

  def <=>(rhs)
    return @values <=> rhs.values
  end
end

class OrderQuestion::Generator < MultipleChoiceQuestion::Generator
  Question = OrderQuestion

  def initialize(value, n=4, m=3)
    super(n)
    @m = m
    @value = value
    @values = value.values.to_a
  end

  def pick_choices
    values = pick_choices_from(@values, @m-1)
    values << @value
    correct_choice = make_choice(values.sort)

    choices = [ ]
    values.permutation.each do |p|
      choice = make_choice(p)
      next if choice == correct_choice
      choices << choice
      break if choices.length == @n-1
    end

    return correct_choice, choices
  end

  def correct_choice_idx(choices)
  end

  def make_choice(values)
    return OrderQuestion::Choice.new(values)
  end
end

end
