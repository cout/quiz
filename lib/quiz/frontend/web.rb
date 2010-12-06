require 'webrick'
require 'yajl'

require 'quiz/quiz'
require 'quiz/definitions'
require 'quiz/multiple_choice_question'

module Quiz

class MultipleChoiceQuestion < Question
  def to_json
    choices = { }
    self.choices.each_with_index do |choice, idx|
      choices[multi(idx)] = choice
    end

    h = { 
      :choices => choices,
      :correct_choice => self.correct_response,
    }

    encoder = Yajl::Encoder.new
    return encoder.encode(h)
  end
end

class WebServer < WEBrick::HTTPServer
  attr_reader :set
  attr_reader :quiz
  attr_reader :generators

  def self.run(config)
    config[:Port] ||= 7819 # "QUIZ"
    server = self.new(config)
    server.mount_all
    ['INT', 'TERM'].each do |signal|
      trap(signal) { server.shutdown }
    end
    server.start
  end

  def initialize(config)
    super(config)

    @set = Definitions.load_set(*config[:set])
    @generators = MultipleChoiceQuestion::Generator.create_generators(*set)
    @quiz = Quiz.new(self, *generators)
  end

  def mount_all
    self.mount('/question', QuestionServlet)
  end
end

class Servlet < WEBrick::HTTPServlet::AbstractServlet
  def json_response(response, obj)
    encoder = Yajl::Encoder.new
    json = encoder.encode(obj)

    response['content-type'] = 'text/plain'
    response.body = json
  end
end

class QuestionServlet < Servlet
  def initialize(server)
    super(server)
    @quiz = server.quiz
  end

  def do_GET(request, response)
    question = @quiz.next_question()
    json_response(response, question)
  end
end

class ResponseServlet < Servlet
  def initialize(server)
    super(server)
    @quiz = server.quiz
  end

  def do_GET(request, response)
    question = @quiz.next_question()
    json_response(question)
  end
end

=begin
  def get_response
    # @outfile.print "? "
    # @outfile.flush
    # response = @infile.gets
    # response.chomp!
    # return response
  end

  def correct_response(question)
    report "!!! Correct !!!"
  end

  def incorrect_response(question)
    report "No, the correct response was #{question.correct_response}"
  end

  def encourage(encouragement)
    report encouragement
  end

  def report(str)
    # TODO
  end
end

=end

end

