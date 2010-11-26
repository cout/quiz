module Quiz

class Definition
  include Comparable

  attr_reader :term
  attr_reader :definition
  attr_reader :definitions

  def initialize(term, definition, definitions)
    @term = term
    @definition = definition
    @definitions = definitions
  end

  def to_s
    return "#{term} - #{definition}"
  end

  def inspect
    return "#<Quiz::Definition @term=#{@term.inspect} @definition=#{@definition.inspect}>"
  end

  def <=>(rhs)
    return [ term, definition ] <=> [ rhs.term, rhs.definition ]
  end

  def =~(rhs)
    return term == rhs.term || definition == rhs.definition
  end
end

end

