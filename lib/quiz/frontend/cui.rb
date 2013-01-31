module Quiz

class CuiFrontend
  def initialize(infile=STDIN, outfile=STDOUT)
    @infile = infile
    @outfile = outfile
  end

  def main_loop(quiz)
    loop do
      question = quiz.next_question()
      show_question(question)
      response = get_response()
      quiz.got_response(question, response)
    end
  end

  def show_question(question)
    @outfile.puts "================================="
    first = true
    question.to_s.each_line do |line|
      puts line
      sleep 2 if first
      first = false
    end
    @outfile.puts "================================="
  end

  def get_response
    @outfile.print "? "
    @outfile.flush
    response = @infile.gets
    response.chomp!
    return response
  end

  def correct_response(question)
    puts "!!! Correct !!!"
    puts
  end

  def incorrect_response(question)
    puts "No, the correct response was #{question.correct_response}"
    puts
  end

  def encourage(encouragement)
    puts encouragement
  end
end

end

