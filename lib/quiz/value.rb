module Quiz

class Value
  attr_reader :value
  attr_reader :name
  attr_reader :values

  def initialize(s_value, value, name, values)
    @s_value = s_value
    @value = value
    @name = name
    @values = values
  end

  def to_s
    return "#{@name}=#{@value}"
  end

  def inspect
    return "#<Quiz::Value @name=#{@name} @value=#{@value}>"
  end

  def <=>(rhs)
    return [ @value, @name ] <=> [rhs.value, rhs.name ]
  end
end

end

