class Rblog
  def initialize(postTxt, template, postHTML)
    @postTxt = postTxt
    @template = template
    @postHTML = postHTML
  end

  def insert
    @template.each_line do |line|
      if line.include? '<div id="content">'
        @postHTML.puts line
        @postTxt.each_line do |line|
          if line == "\n"
            @postHTML.puts "<br/>"
          elsif line =~ /\*\*(.*?)\*\*/
            wordsA = line.split

            wordsA.each do |word|
              puts word
              if word.include? "*"
                word = word.gsub(/[*]/, "") 
                @postHTML.puts "<b>#{word}</b>"
              else
                @postHTML.puts "#{word}"
              end
            end
            elsif line =~ /\_\_(.*?)\_\_/
            wordsA = line.split

            wordsA.each do |word|
              puts word
              if word.include? "_"
                word = word.gsub(/[_]/, "") 
                @postHTML.puts "<i>#{word}</i>"
              else
                @postHTML.puts "#{word}"
              end
            end
          else
            @postHTML.puts line
          end
        end
      else
        @postHTML.puts line
      end
    end
  end
end

def openFile(name)
  begin
    file = File.new(name, "r")
    # file.each_line do |line|
    #   puts line
    # end
  rescue 
    puts 'File doesn\'t exist'
  end
end

if ARGV.size < 1
  puts "Specify a file name"
  exit
end

postTxt = openFile(ARGV[0])
template = openFile("template.html")
postHTML = File.new("post.html", "w+")

rblog = Rblog.new(postTxt, template, postHTML)
rblog.insert


