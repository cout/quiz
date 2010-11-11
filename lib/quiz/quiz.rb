class Quiz
  def go(file=$stdin)
    loop do
      question = ask()
      puts "================================="
      puts question
      puts "================================="
      print "? "
      $stdout.flush
      answer = file.gets
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

