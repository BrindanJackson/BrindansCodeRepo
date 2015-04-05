#Parser Class
class Parser

  def initialize(token_list, token_types)
    @token_list = token_list #array of tokens
    @token_types = token_types #array of token types
    @current_tok = 0
    @program
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
    @current_tok = @current_tok + 1
  end


  #Start of DS breakdown
  #Decl class
  class Decl
    def initialize
      @id
      @decl
    end

    def ParseDecl
      @id = current_token
      skip_token

      #if ;
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
      #skip int
      skip_token
      @decl = Decl.new()
      @decl.ParseDecl

      #skip ;
      skip_token

      if current_type == 4
        @ds = DS.new()
        @decl.ParseDS
      end
    end
  end #end DS class
  #End of DS breakdown


  #Start of SS breakdown


  #Id class
  class Id
    def initialize
      @id
    end

    def ParseId
      @id = current_token
      skip_token
    end
  end #end of Id class

  #Op class
  class Op
    def initialize
      @no
      @id
      @exp
    end

    def ParseOp
      #if Integer
      if current_type == 31
        @no = current_token
        skip_token
      #if Identifier
      elsif current_type == 32
        @id = current_token
      #if Parentheses
      elsif current_type == 20
        skip_token
        @exp = Exp.new()
        @exp.ParseExp
        skip_token
      end
    end
  end #end of Op class

  #Trm class
  class Trm
    def initialize
      @op
      @multiply = 0
      @trm
    end

    def ParseTrm
      @op = Op.new()
      @op.ParseOp
      if current_type == 24
        @multiply = 1
        skip_token
        @trm = Trm.new()
        @trm.ParseTrm
      end
    end
  end #end of Trm class

  #Exp class
  class Exp
    def initialize
      @trm
      @expType = 0
      @exp
    end

    def ParseExp
      @trm = Trm.new()
      @trm.ParseTrm

      #if Plus
      if current_type == 22
        @expType = 1
        skip_token
        @exp = Exp.new()
        @exp.ParseExp
      #if Minus
      elsif current_type == 23
        @expType = 2
        skip_token
        @exp = Exp.new()
        @exp.ParseExp
      end
    end
  end #end of Exp class

  #Assign class
  class Assign
    def initialize
      @id
      @exp
    end

    def ParseAssign
      @id = Id.new()
      @id.ParseId
      skip_token
      @exp = Exp.new()
      @exp.ParseExp
    end
  end #end of Assign class

  #class Comp
  class Comp
    def initialize
      @op1
      @compOp = 0
      @op2
    end

    def ParseComp

      #skip (
      skip_token
      @op1 = Op.new()
      @op1.ParseOp

      #if !=
      if current_type == 25
        @compOp = 1
      #if ==
      elsif current_type == 26
        @compOp = 2
      #if <
      elsif current_type == 27
        @compOp = 3
      #if >
      elsif current_type == 28
        @compOp = 4
      #if <=
      elsif current_type == 29
        @compOp = 5
      #if >=
      elsif current_type == 30
        @compOp = 6
      end

      skip_token
      @op2 = Op.new()
      @op2.ParseOp

    end
  end #end class Comp

  #Cond class
  class Cond
    def initialize
      @comp
      @cond1
      @andOr = 0
      @cond2
    end

    def ParseCond

      #if (
      if current_type == 20
        @comp = Comp.new()
        @comp.ParseComp
        #skip )
        skip_token
      #if !
      elsif current_type == 15
        skip_token
        @cond1 = Cond.new()
        @cond1.ParseCond
      #if [
      elsif current_type == 16
        #skip [
        skip_token

        @cond1 = Cond.new()
        @cond1.ParseCond

        #if &&
        if current_type == 18
          @andOr = 1
        #if ||
        elsif current_type == 19
          @andOr = 2
        end

        #skip && or ||
        skip_token

        @cond2 = Cond.new()
        @cond2.ParseCond

        #skip ]
        skip_token

      end
    end
  end #end of Cond class

  #If class
  class If
    def initialize
      @cond
      @ss1
      @ss2
    end

    def ParseIf
      #skip if token
      skip_token

      @cond = Cond.new()
      @cond.ParseCond

      #skip then token
      skip_token

      @ss1 = SS.new()
      @ss1.ParseSS

      #skip ;
      skip_token

      if current_type == 7
        #skip else
        skip_token

        @ss2 = SS.new()
        @ss2.ParseSS

        #skip ;
        skip_token
      end

      #skip end
      skip_token
    end
  end #end of If class

  #Loop class
  class Loop
    def initialize
      @cond
      @ss
    end

    def ParseLoop
      #skip while
      skip_token

      @cond = Cond.new()
      @cond.ParseCond

      #skip loop
      skip_token

      @ss = SS.new()
      @ss.ParseSS

      #skip ;
      skip_token

      #skip end
      skip_token
    end

  end #end of Loop class

  #IdList class
  class IdList
    def initialize
      @id
      @idList
    end

    def ParseIdList
      @id = Id.new()
      @id.ParseId

      if current_type == 13
        #skip ,
        skip_token

        @idList = IdList.new()
        @idList.ParseIdList
      end
    end
  end #end IdList class

  #In class
  class In
    def initialize
      @idList
    end

    def ParseIn
      #skip read
      skip_token

      @idList = IdList.new()
      @idList.ParseIdList
    end
  end #end of In class

  #Out class
  class Out
    def initialize
      @idList
    end

    def ParseIn
      #skip write
      skip_token

      @idList = IdList.new()
      @idList.ParseIdList
    end
  end #end of Out class

  #Stmt class
  class Stmt
    def initialize
      @assign
      @if
      @loop
      @in
      @out
    end

    def ParseStmt
      #parses depending on statment type
      #if ID
      if current_type == 32
        @assign = Assign.new()
        @assign.ParseAssign

      #if If
      elsif current_type == 5
        @if = If.new()
        @if.ParseIf

      #if While
      elsif current_type == 8
        @loop = Loop.new()
        @loop.ParseLoop

      #if Read
      elsif current_type == 10
        @in = In.new()
        @in.ParseIn

      #if Write
      elsif current_type == 11
        @out = Out.new()
        @out.ParseOut
      end
    end
  end #end Stmt class

  #SS class
  class SS
    def initialize
      @stmt
      @ss
    end

    def ParseSS
      #skip begin
      skip_token

      #if Assign or If or Loop or In or Out
      if(current_type == 32 || current_type == 5 || current_type == 8 || current_type == 10 || current_type == 11)
        @stmt = Stmt.new()
        @stmt.ParseStmt
        @ss = SS.new()
        @ss.ParseSS
      end
    end
  end #end SS class
  #End of SS breakdown


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

  def program
    @program = Prog.new()
    @program.ParseProg
  end

end #end of Parser class
