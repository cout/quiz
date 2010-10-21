require 'quiz'

#definitions = Definitions.load('test.txt')
definitions = Definitions.load('biology_ch_9.txt')
quiz = MultipleChoiceQuiz.new(definitions)
quiz.go

