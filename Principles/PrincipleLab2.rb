#Tokenizer Class
class Tokenizer
  def initialize(unparsed)
    @token_list = []
    @token_types = []
    @token = ""
    @unparsed_string = unparsed
    @current_index = 0
    @current_char = ""
    @error_msg = "Error"
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
            @token_type.push(32)
          end
        else
          @token_list.push(@token)
          @token_type.push(32)
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
          @token_type.push(31)
        end
        
      #checks all else
      elsif


      end
    end
  #End of function Tokenize
  end

#end of Class Tokenizer
end
