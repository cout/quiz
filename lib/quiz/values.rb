require 'quiz/value'

module Quiz

class Values
  def initialize
    @a = [ ]
  end

  def add_value(s_value, value, name)
    d = Value.new(s_value, value, name, self)
    @a << d
  end

  def self.load_set(*filenames)
    set = [ ]
    filenames.each do |filename|
      set << self.load(filename)
    end
    return set
  end

  def self.load(filename)
    values = self.new
    value = nil

    File.open(filename) do |file|
      file.each_line do |line|
        line.chomp!

        case line
        when /^\s*$/, /^#/
          # comment
        when /^(.*?)\s+-\s+(.*)/m
          # value
          value = $1
          name = $2
          if not self.is_todo(name) then
            values.add_value(value, value.to_f, name)
          end
        when /^(.*?)\s+=\s+(.*)/m
          name = $1
          value = $2
          if not self.is_todo(value) then
            values.add_value(value, value.to_f, name)
          end
        end
      end
    end

    return values
  end

  def self.is_todo(str)
    return str =~ /\*TODO\*/
  end

  def to_a
    return @a
  end

  def each(&block)
    @a.each(&block)
  end
end

end
