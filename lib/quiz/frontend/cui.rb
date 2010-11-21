class CuiFrontend
  def initialize(infile=STDIN, outfile=STDOUT)
    @infile = infile
    @outfile = outfile
  end

  def show_question(question)
    @outfile.puts "================================="
    @outfile.puts question
    @outfile.puts "================================="
  end

  def get_response()
    @outfile.print "? "
    @outfile.flush
    answer = @infile.gets
    answer.chomp!
    return answer
  end
end
