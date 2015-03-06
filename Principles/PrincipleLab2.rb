#Tokenizer Class
class Tokenizer
  def initialize(unparsed)
    @token_list = []
    @token_types = []
    @token = ""
    @unparsed_string = unparsed
    @current_index = 0
    @current_char = ""
  end

  #If not at end of @unparsed_string, increment @current_index
  #Assign character at @current_index to @current_character
  def nextChar
    if !(@unparsed_string.length() == @current_index=1)
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
      if 
      
      #checks Uppercase identifiers
      elsif

      #checks integers
      elsif

      #checks al else
      elsif


      end
    end
  #End of function Tokenize
  end

#end of Class Tokenizer
end
