module Quiz

class Stats
  attr_reader :choice
  attr_reader :total
  attr_reader :correct

  def initialize(choice)
    @choice = choice
    @total = 0
    @correct = 0
  end

  def record_response(was_correct)
    @total += 1
    @correct += was_correct ? 1 : 0
  end

  def percent_correct
    return @correct.to_f / @total
  end
end

end
