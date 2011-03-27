module Quiz

class TtsFrontend
  def initialize
    @espeak_options = '--stdin -v english+f1 -s 130'
  end

  def main_loop(quiz)
    loop do
      question = quiz.next_question()
      read_question(question)
      sleep 5
      read_answer(question)
      sleep 3
    end
  end

  def read_question(question)
    speak(question.question)
  end

  def read_answer(question)
    speak("The answer is #{question.correct_response}")
  end

  def speak(text)
    system("echo '#{text}' | espeak #{@espeak_options}")
  end
end

end
