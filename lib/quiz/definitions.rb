class Definitions
  def initialize(h)
    @h = h
    @a = h.to_a
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
    return self.new(h)
  end

  def to_a
    return @a
  end
end

