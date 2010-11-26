module Quiz

class Stats
  attr_reader :choice
  attr_reader :definitions
  attr_reader :total
  attr_reader :correct

  def initialize(choice)
    @choice = choice
    @total = 0
    @correct = 0
  end

  def record_correct_response
    @total += 1
    @correct += 1
  end

  def record_incorrect_response
    @total += 1
    @correct += 0
  end

  def percent_correct
    return @correct.to_f / @total
  end
end

end
