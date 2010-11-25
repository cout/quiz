require 'quiz/definition'

module Quiz

class Definitions
  def initialize(h)
    @h = h
    @a = h.to_a
  end

  def self.load_set(*filenames)
    set = [ ]
    filenames.each do |filename|
      set << Definitions.load(filename)
    end
    return set
  end

  def self.load(filename)
    h = { }
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
          h[term] = Definition.new(term, definition)
        when /^(.*)\s+\|/
          prev_line = $1 + "\n"
        else
          definition << ' ' if definition[-1] == ?.
          definition << ' ' << line
        end
      end
    end
    self.ignore_todo(h)
    return self.new(h)
  end

  def self.ignore_todo(h)
    h.delete_if do |key, definition|
      definition =~ /\*TODO\*/
    end
  end

  def to_a
    return @a
  end
end

end
