#Parser Class
class Parser

  def initialize(token_list, token_types)
    @token_list = token_list #array of tokens
    @token_types = token_types #array of token types
    @current_tok = 0
  end

  #returns current token
  def current_token
    @token_list[@current_tok]
  end

  #returns tpye of current token
  def current_type
    @token_type[@current_tok]
  end

  def skip_token
    @current_tok++
  end

  #Decl class
  class Decl
    def initialize
      @id
      @decl
    end

    def ParseDecl
      @id = current_token
      skip_token

      if current_type != 12
        skip_token
        @decl = Decl.new()
        @decl.ParseDecl
      end
    end
  end #end of Decl class

  #DS class
  class DS
    def initialize
      @decl
      @ds
    end

    def ParseDS
      skip_token
      @decl = Decl.new()
      @decl.ParseDecl

      skip_token
      if current_type != 4
        @ds = DS.new()
        @decl.ParseDS
      end
    end
  end #end DS class

  #SS class
  class SS
    def initialize

    end

    def ParseSS

    end
  end #end SS class

  #progam class
  class Prog
    def initialize
      @ds
      @ss
    end

    def ParseProg
      #skip the program token
      skip_token

      @ds = DS.new()
      @ds.ParseDS
      @ss = SS.new()
      @ss.ParseSS
    end
  end #end of Prog class

end #end of Parser class
