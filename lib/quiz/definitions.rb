require 'quiz/definition'

module Quiz

class Definitions
  def initialize(h={})
    @h = h if h
    @a = h.values
  end

  def add_definition(term, definition)
    d = Definition.new(term, definition, self)
    @h[term] = d
    @a << d
  end

  def self.load_set(*filenames)
    set = [ ]
    filenames.each do |filename|
      set << Definitions.load(filename)
    end
    return set
  end

  def self.load(filename)
    definitions = self.new
    definition = nil
    prev_line = ''

    File.open(filename) do |file|
      file.each_line do |line|
        line.chomp!
        line = prev_line + line
        prev_line = ''

        case line
        when /^\s*$/, /^#/
          # comment
        when /^(.*?)\s+-\s+(.*)/m
          # definition
          term = $1
          definition = $2
          if not self.is_todo(definition) then
            definitions.add_definition(term, definition)
          end
        when /^(.*)\s+\|/
          prev_line = $1 + "\n"
        else
          definition << ' ' if definition[-1] == ?.
          definition << ' ' << line
        end
      end
    end

    return definitions
  end

  def self.is_todo(definition)
    return definition =~ /\*TODO\*/
  end

  def to_a
    return @a
  end

  def to_h
    return @h
  end

  def each(&block)
    @a.each(&block)
  end
end

end
