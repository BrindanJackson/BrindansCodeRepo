#PrinciplesLab2.rb

#Tokenizer Class
class Tokenizer
  #Initilizes all class variables
  def initialize(unparsed)
    @token_list = [] #array of tokens
    @token_types = [] #array of token types
    @token = "" #current token being analyzed
    @unparsed_string = unparsed #string being parsed
    @current_index = 0 #current index of string being parsed
    @current_char = @unparsed_string[0] #current character in string being parsed
    @error_msg = "Error: Illegal token encountered" #error message to be displayed
  end
  
  #Puts new string into Tokenizer class
  def newString(string)
    @unparsed_string = string
    @current_index = 0
    @current_char = @unparsed_string[0]
    @token = ""
  end

  #displays @token_types array to the terminal
  def show
    @token_types.each do |tok|
      if tok != 34
        puts tok
      else
        puts @error_msg
      end
    end
  end

  #States whether x is uppercase
  def upperCase?(x)
    x =~ /[A-Z]/
  end
  #States whether x is lowercase
  def lowerCase?(x)
    x =~ /[a-z]/
  end

  #states whether x is a digit
  def number?(x)
    x =~ /[0-9]/
  end

  #If not at end of @unparsed_string, increment @current_index
  #Assign character at @current_index to @current_character
  def nextChar
    if !(@unparsed_string.length() == @current_index+1)
      @current_index = @current_index + 1
      @current_char = @unparsed_string[@current_index]
    end
  #End of function nextChar
  end

  #parses the string and puts the tokens into @token_list
  #and puts the token type ids into @token_types
  def tokenize
    done = 0

    while done == 0 do

      #Goes through character by character to find tokens

      #checks lower case reserved words
      if lowerCase?(@current_char)
        #Checking the first few characters in the string for a specific token
        #Taking a found token and adding it to the @token_list array
        if @unparsed_string[@current_index..@current_index+6] == "program"
          @current_index = @current_index + 7
          @current_char = @unparsed_string[@current_index]
          @token_list.push("program")
          @token_types.push(1)
        elsif @unparsed_string[@current_index..@current_index+4] == "begin"
          @current_index = @current_index + 5
          @current_char = @unparsed_string[@current_index]
          @token_list.push("begin")
          @token_types.push(2)
        elsif @unparsed_string[@current_index..@current_index+2] == "end"
          @current_index = @current_index + 3
          @current_char = @unparsed_string[@current_index]
          @token_list.push("end")
          @token_types.push(3)
        elsif @unparsed_string[@current_index..@current_index+2] == "int"
          @current_index = @current_index + 3
          @current_char = @unparsed_string[@current_index]
          @token_list.push("int")
          @token_types.push(4)
        elsif @unparsed_string[@current_index..@current_index+1] == "if"
          @current_index = @current_index + 2
          @current_char = @unparsed_string[@current_index]
          @token_list.push("if")
          @token_types.push(5)
        elsif @unparsed_string[@current_index..@current_index+3] == "then"
          @current_index = @current_index + 4
          @current_char = @unparsed_string[@current_index]
          @token_list.push("then")
          @token_types.push(6)
        elsif @unparsed_string[@current_index..@current_index+3] == "else"
          @current_index = @current_index + 4
          @current_char = @unparsed_string[@current_index]
          @token_list.push("else")
          @token_types.push(7)
        elsif @unparsed_string[@current_index..@current_index+4] == "while"
          @current_index = @current_index + 5
          @current_char = @unparsed_string[@current_index]
          @token_list.push("while")
          @token_types.push(8)
        elsif @unparsed_string[@current_index..@current_index+3] == "loop"
          @current_index = @current_index + 4
          @current_char = @unparsed_string[@current_index]
          @token_list.push("loop")
          @token_types.push(9)
        elsif @unparsed_string[@current_index..@current_index+3] == "read"
          @current_index = @current_index + 4
          @current_char = @unparsed_string[@current_index]
          @token_list.push("read")
          @token_types.push(10)
        elsif @unparsed_string[@current_index..@current_index+4] == "write"
          @current_index = @current_index + 5
          @current_char = @unparsed_string[@current_index]
          @token_list.push("write")
          @token_types.push(11)
        else
          @token_list.push(@error_msg)
          @token_types.push(34)
          done = 1
        end
        
        if @current_index == @unparsed_string.length()
          done = 1
        end
      
      #checks Uppercase identifiers
      elsif upperCase?(@current_char)
        @token = ""
        while (!(@unparsed_string.length() == @current_index+1)) && upperCase?(@current_char) do
          @token = @token + @current_char
          nextChar
        end

        if ((@unparsed_string.length() == @current_index+1) && upperCase?(@current_char))
          @token = @token + @current_char
          @token_list.push(@token)
          @token_types.push(32)
          done = 1
        elsif lowerCase?(@current_char)
          @token_list.push(@error_msg)
          @token_types.push(34)
          done = 1
        elsif number?(@current_char)
          while (!(@unparsed_string.length() == @current_index+1)) && number?(@current_char) do
            @token = @token + @current_char
            nextChar
          end
          
          if (@unparsed_string.length() == @current_index+1) && number?(@current_char)
            @token = @token + @current_char
            @token_list.push(@token)
            @token_types.push(32)
            done = 1
          elsif upperCase?(@current_char) || lowerCase?(@currentChar)
            @token_list.push(@error_msg)
            @token_types.push(34)
            done = 1
          else
            @token_list.push(@token)
            @token_types.push(32)
          end
        else
          @token_list.push(@token)
          @token_types.push(32)
        end
        
      #checks integers
      elsif number?(@current_char)
        @token = ""

        while (!(@unparsed_string.length() == @current_index+1)) && number?(@current_char) do
          @token = @token + @current_char
          nextChar
        end

        if (@unparsed_string.length() == @current_index+1) && number?(@current_char)
          @token = @token + @current_char
          @token_list.push(@token)
          @token_types.push(31)
          done = 1
        elsif upperCase?(@current_char) || lowerCase?(@current_char)
          @token_list.push(@error_msg)
          @token_types.push(34)
        else
          @token_list.push(@token)
          @token_types.push(31)
        end
        
      #checks special characters
      elsif @current_char == ";"
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push(";")
          @token_types.push(12)
          nextChar
        else
          @token_list.push(";")
          @token_types.push(12)
          done = 1
        end
      elsif @current_char == ","
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push(",")
          @token_types.push(13)
          nextChar
        else
          @token_list.push(",")
          @token_types.push(13)
          done = 1
        end
      elsif @current_char == "="
        @token = ""
        if !(@unparsed_string.length() == @current_index+1)
          @token = @token + "="
          nextChar
          if !(@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(26)
            nextChar
          elsif (@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(26)
            done = 1
          else
            @token_list.push("=")
            @token_types.push(14)
          end
        else
          @token_list.push("=")
          @token_types.push(14)
          done = 1
        end
      elsif @current_char == "!"
        @token = ""
        if !(@unparsed_string.length() == @current_index+1)
          @token = @token + "!"
          nextChar
          if !(@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(25)
            nextChar
          elsif (@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(25)
            done = 1
          else
            @token_list.push("!")
            @token_types.push(15)
          end
        else
          @token_list.push("!")
          @token_types.push(15)
          done = 1
        end
      elsif @current_char == "["
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push("[")
          @token_types.push(16)
          nextChar
        else
          @token_list.push("[")
          @token_types.push(16)
          done = 1
        end
      elsif @current_char == "]"
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push("]")
          @token_types.push(17)
          nextChar
        else
          @token_list.push("]")
          @token_types.push(17)
          done = 1
        end
      elsif @current_char == "&"
        @token = ""
        if !(@unparsed_string.length() == @current_index+1)
          @token = @token + "&"
          nextChar
          if !(@unparsed_string.length() == @current_index+1) && @current_char == "&"
            @token = @token + "&"
            @token_list.push(@token)
            @token_types.push(18)
            nextChar
          elsif (@unparsed_string.length() == @current_index+1) && @current_char == "&"
            @token = @token + "&"
            @token_list.push(@token)
            @token_types.push(18)
            done = 1
          else
            @token_list.push(@error_msg)
            @token_types.push(34)
          end
        else
          @token_list.push(@error_msg)
          @token_types.push(34)
          done = 1
        end
      elsif @current_char == "|"
        @token = ""
        if !(@unparsed_string.length() == @current_index+1)
          @token = @token + "|"
          nextChar
          if !(@unparsed_string.length() == @current_index+1) && @current_char == "|"
            @token = @token + "|"
            @token_list.push(@token)
            @token_types.push(19)
            nextChar
          elsif (@unparsed_string.length() == @current_index+1) && @current_char == "&"
            @token = @token + "|"
            @token_list.push(@token)
            @token_types.push(19)
            done = 1
          else
            @token_list.push(@error_msg)
            @token_types.push(34)
          end
        else
          @token_list.push(@error_msg)
          @token_types.push(34)
          done = 1
        end
      elsif @current_char == "("
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push("(")
          @token_types.push(20)
          nextChar
        else
          @token_list.push("(")
          @token_types.push(20)
          done = 1
        end
      elsif @current_char == ")"
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push(")")
          @token_types.push(21)
          nextChar
        else
          @token_list.push(")")
          @token_types.push(21)
          done = 1
        end
      elsif @current_char == "+"
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push("+")
          @token_types.push(22)
          nextChar
        else
          @token_list.push("+")
          @token_types.push(22)
          done = 1
        end
      elsif @current_char == "-"
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push("-")
          @token_types.push(23)
          nextChar
        else
          @token_list.push("-")
          @token_types.push(23)
          done = 1
        end
      elsif @current_char == "*"
        if !(@unparsed_string.length() == @current_index+1)
          @token_list.push("*")
          @token_types.push(24)
          nextChar
        else
          @token_list.push("*")
          @token_types.push(24)
          done = 1
        end
      elsif @current_char == "<"
        @token = ""
        if !(@unparsed_string.length() == @current_index+1)
          @token = @token + "<"
          nextChar
          if !(@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(29)
            nextChar
          elsif (@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(29)
            done = 1
          else
            @token_list.push("<")
            @token_types.push(27)
          end
        else
          @token_list.push("<")
          @token_types.push(27)
          done = 1
        end
      elsif @current_char == ">"
        @token = ""
        if !(@unparsed_string.length() == @current_index+1)
          @token = @token + ">"
          nextChar
          if !(@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(30)
            nextChar
          elsif (@unparsed_string.length() == @current_index+1) && @current_char == "="
            @token = @token + "="
            @token_list.push(@token)
            @token_types.push(30)
            done = 1
          else
            @token_list.push(">")
            @token_types.push(28)
          end
        else
          @token_list.push(">")
          @token_types.push(28)
          done = 1
        end
      #Takes care of the whitespace characters
      elsif @current_char == "\n" || @current_char == "\t" || @current_char == "\r" || @current_char == " "
        if !(@unparsed_string.length() == @current_index+1)
          nextChar
        else
          done = 1
        end
      #Takes care of the null character
      elsif @current_char == "\0"
        done = 1
      else
        nextChar
      end
    end
    @token_list.push("EOF")
    @token_types.push(33)
  #End of Function Tokenize
  end

#End of Class Tokenizer
end

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
else
  puts "Error: Too many or too few arguments"
end
