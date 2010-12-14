module Quiz

class Choice
  def as_question
    raise NotImplementedError
  end

  def as_choice
    raise NotImplementedError
  end
end

end

