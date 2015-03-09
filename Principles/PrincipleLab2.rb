#Tokenizer Class
class Tokenizer
  def initialize(unparsed)
    @token_list = []
    @token_types = []
    @token = ""
    @unparsed_string = unparsed
    @current_index = 0
    @current_char = @unparsed_string[0]
    @error_msg = "Error"
  end

  def show
    puts @token_list
    puts @token_types
  end

  def upperCase?(x)
    x =~ /[A-Z]/
  end

  def lowerCase?(x)
    x =~ /[a-z]/
  end

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
        
      #checks all else
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
      elsif @current_char == "\n" || @current_char == "\t" || @current_char == "\r" || @current_char == " "
        if !(@unparsed_string.length() == @current_index+1)
          nextChar
        else
          done = 1
        end
      elsif @current_char == "\0"
        done = 1
      else
        nextChar
      end
    end
  #End of Function Tokenize
  end

#End of Class Tokenizer
end


x = Tokenizer.new ("XD 2 program;===")
x.tokenize
x.show
