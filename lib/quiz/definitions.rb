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
    File.open(filename) do |file|
      file.each_line do |line|
        line.chomp!
        case line
        when /^\s*$/, /^#/
          # comment
        when /^(.*?)\s+-\s+(.*)/
          # definition
          term = $1
          definition = $2
          h[term] = definition
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
