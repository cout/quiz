class Quiz
  def go
    loop do
      question = ask()
      puts "================================="
      puts question
      puts "================================="
      print "? "
      $stdout.flush
      answer = gets
      answer.chomp!
      if answer == question.answer then
        puts "Correct"
      else
        puts "No, the correct answer was #{question.answer}"
      end
      puts
    end
  end
end

