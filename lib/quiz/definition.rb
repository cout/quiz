module Quiz

class Definition
  attr_reader :term
  attr_reader :definition

  def initialize(term, definition)
    @term = term
    @definition = definition
  end
end

end

