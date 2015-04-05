#PrinciplesLab2.rb
require_relative "TokenizerClass"
require_relative "ParserClass"


#new instance of tokenizer and new string
x = Tokenizer.new ("")
string_to_parse = ""

#checks for correct ammount of command line arguments
if ARGV.length == 1
  file_name = ARGV[0]

  #opens file with filename given in command line argument 1
  f = File.open(file_name, "r")

  #retrieve all of the lines from the file and closes file
  f.each_line do |line|
    string_to_parse = string_to_parse + line
  end

  f.close

  #parses string
  x.newString(string_to_parse)
  x.tokenize

  #displays string
  x.show

  y = Parser.new(x.token_list, x.token_types)
  y.program
else
  puts "Error: Too many or too few arguments"
end
