require 'quiz/conjugation'

module Quiz

class Conjugations
  def initialize(h={})
    @conjugations = [ ]
    @conjugations_by_verb = { }
  end

  def self.load_set(*filenames)
    set = [ ]
    filenames.each do |filename|
      set << self.load(filename)
    end
    return set
  end

  def self.load(filename)
    conjugations = self.new
    subjects = nil

    File.open(filename) do |file|
      file.each_line do |line|
        case line
        when /^#.*/
        when /^$/
        when /^subjects:\s+(.*)/
          subjects = $1.split(/,\s+/)
        when /(.*?)\s+\((.*?)\)\s+-\s+(.*)/
          verb = $1
          tense = $2
          conjugation_forms = $3.split(/,\s*/)
          conjugation_forms.each_with_index do |form, idx|
            subject = subjects[idx]
            next if subject == '-' or form == '-'
            conjugations.add_conjugation(verb, tense, subjects[idx], form)
          end
        end
      end
    end

    return conjugations
  end

  def add_conjugation(verb, tense, subject, conjugation)
    conjugation = Conjugation.new(verb, tense, subject, conjugation, self)
    @conjugations << conjugation
    @conjugations_by_verb[verb] ||= [ ]
    @conjugations_by_verb[verb] << conjugation
  end

  def by_verb(verb)
    return @conjugations_by_verb[verb]
  end

  def self.is_todo(definition)
    return definition =~ /\*TODO\*/
  end

  def to_a
    return @conjugations
  end

  def to_h
    return @conjugations_by_verb
  end

  def each(&block)
    @conjugations.each(&block)
  end
end

end
