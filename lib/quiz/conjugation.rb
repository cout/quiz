require 'quiz/choice'

module Quiz

class Conjugation < Choice
  include Comparable

  attr_reader :verb
  attr_reader :tense
  attr_reader :subject
  attr_reader :conjugations

  def initialize(verb, tense, subject, conjugation, conjugations)
    @verb = verb
    @tense = tense
    @subject = subject
    @conjugation = conjugation
    @conjugations = conjugations
  end

  def as_question
    return "#{subject} _____ (#{verb}, #{tense})"
  end

  def as_choice
    return @conjugation
  end

  def inspect
    return "#<Quiz::Conjugation " \
           "@verb=#{@verb.inspect} " \
           "@tense=#{@tense.inspect} " \
           "@subject=#{@subject.inspect} " \
           "@conjugation=#{@conjugation.inspect}>"
  end

  def <=>(rhs)
    return [ verb, tense, subject ] <=> [ rhs.verb, rhs.tense, rhs.subject ]
  end

  def =~(rhs)
    return (verb == rhs.verb) && (tense == rhs.tense) && (subject == rhs.subject)
  end
end

end

