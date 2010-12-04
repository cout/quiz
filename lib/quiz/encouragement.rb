class Encouragement
  def self.after_response(stats, was_correct)
    msg = ''

    # TODO: only remember the last 10 or so responses
    if stats.total > 3 and \
      stats.percent_correct < 0.33 then
      missed_times = stats.total - stats.correct
      msg << "You've missed this question #{missed_times} out of #{stats.total} times\n"
      msg << "Remember the answer, because you'll probably be asked it again!\n"
    end

    if stats.correct > 3 and \
      was_correct and \
      (stats.correct - 1).to_f / stats.total < 0.67 and \
      stats.percent_correct >= 0.67 then
      msg << "Congratulations, you're starting to get this question right more often!\n"
    end

    return self.new(msg)
  end

  attr_reader :msg

  def initialize(msg)
    @msg = msg
  end

  def to_s
    return @msg.to_s
  end
end

