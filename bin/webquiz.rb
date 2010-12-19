require 'quiz/frontend/web'

if __FILE__ == $0 then

if not ARGV[0] then
  puts "Usage: #$0 <filename> [ <filename> ... ]"
  exit 1
end

config = {
  :set => ARGV
}

Quiz::WebServer.run(config)

end

