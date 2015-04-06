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

    def ParseDecl(tokens, types, i)
      @id = tokens[i]
      i=i+1

      #if ;
      if types[i] != 12
        i=i+1
        @decl = Decl.new()
        i = @decl.ParseDecl(tokens, types, i)
      end
      i
    end

    def PrintDecl
      print @id + " "

      if @decl
        print ", "
        @decl.PrintDecl
      end

    end
  end #end of Decl class

  #DS class
  class DS
    def initialize
      @decl
      @ds
    end

    def ParseDS(tokens, types, i)
      #skip int
      i=i+1
      @decl = Decl.new()
      i = @decl.ParseDecl(tokens, types, i)

      #skip ;
      i=i+1

      #if int
      if types[i] == 4
        @ds = DS.new()
        i = @ds.ParseDS(tokens, types, i)
      end
      i
    end

    def PrintDS(tab)
      tab.times do
        print "\t"
      end

      print "int "

      @decl.PrintDecl

      puts ";"

      if @ds
        @ds.PrintDS(tab)
      end

    end #end of PrintDS
  end #end DS class
  #End of DS breakdown


  #Start of SS breakdown


  #Id class
  class Id
    def initialize
      @id
    end

    def ParseId(tokens, types, i)
      @id = tokens[i]
      i=i+1
    end

    def PrintId
      print @id + " "
    end
  end #end of Id class

  #Op class
  class Op
    def initialize
      @no
      @id
      @exp
    end

    def ParseOp(tokens, types, i)
      #if Integer
      if types[i] == 31
        @no = tokens[i]
        i=i+1
      #if Identifier
    elsif types[i] == 32
        @id = tokens[i]
        i=i+1
      #if Parentheses
    elsif types[i] == 20
        i=i+1
        @exp = Exp.new()
        i = @exp.ParseExp(tokens, types, i)
        i=i+1
      end
      i
    end

    def PrintOp
      if @no
        print @no + " "
      elsif @id
        print @id + " "
      elsif @exp
        @exp.PrintExp
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

    def ParseTrm(tokens, types, i)
      @op = Op.new()
      i = @op.ParseOp(tokens, types, i)
      if types[i] == 24
        @multiply = 1
        i=i+1
        @trm = Trm.new()
        i = @trm.ParseTrm(tokens, types, i)
      end
      i
    end

    def PrintTrm
      @op.PrintOp

      if @multiply == 1
        print "* "
        @trm.PrintTrm
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

    def ParseExp(tokens, types, i)
      @trm = Trm.new()
      i = @trm.ParseTrm(tokens, types, i)

      #if Plus
      if types[i] == 22
        @expType = 1
        i=i+1
        @exp = Exp.new()
        i = @exp.ParseExp(tokens, types, i)
      #if Minus
    elsif types[i] == 23
        @expType = 2
        i=i+1
        @exp = Exp.new()
        i = @exp.ParseExp(tokens, types, i)
      end
      i
    end

    def PrintExp
      @trm.PrintTrm

      if @expType == 1
        print "+ "
        @exp.PrintExp
      elsif @expType == 2
        print "- "
        @exp.PrintExp
      end

    end
  end #end of Exp class

  #Assign class
  class Assign
    def initialize
      @id
      @exp
    end

    def ParseAssign(tokens, types, i)
      @id = Id.new()
      i = @id.ParseId(tokens, types, i)
      i=i+1
      @exp = Exp.new()
      i = @exp.ParseExp(tokens, types, i)
    end

    def PrintAssign
      @id.PrintId
      print "= "
      @exp.PrintExp
    end

  end #end of Assign class

  #class Comp
  class Comp
    def initialize
      @op1
      @compOp = 0
      @op2
    end

    def ParseComp(tokens, types, i)

      #skip (
      i=i+1
      @op1 = Op.new()
      i = @op1.ParseOp(tokens, types, i)

      #if !=
      if types[i] == 25
        @compOp = 1
      #if ==
    elsif types[i] == 26
        @compOp = 2
      #if <
    elsif types[i] == 27
        @compOp = 3
      #if >
    elsif types[i] == 28
        @compOp = 4
      #if <=
    elsif types[i] == 29
        @compOp = 5
      #if >=
    elsif types[i] == 30
        @compOp = 6
      end

      i=i+1
      @op2 = Op.new()
      i = @op2.ParseOp(tokens, types, i)

    end

    def PrintComp
      @op1.PrintOp
      if @compOp == 1
        print "!= "
      elsif @compOp == 2
        print "== "
      elsif @compOp == 3
        print "< "
      elsif @compOp == 4
        print "> "
      elsif @compOp == 5
        print "<= "
      elsif @compOp == 6
        print ">= "
      end
      @op2.PrintOp
    end

  end #end class Comp

  #Cond class
  class Cond
    def initialize
      @comp
      @not = 0
      @cond1
      @bracket = 0
      @andOr = 0
      @cond2
    end

    def ParseCond(tokens, types, i)

      #if (
      if types[i] == 20
        @comp = Comp.new()
        i = @comp.ParseComp(tokens, types, i)
        #skip )
        i=i+1
      #if !
    elsif types[i] == 15
        i=i+1
        @not = 1
        @cond1 = Cond.new()
        i = @cond1.ParseCond(tokens, types, i)
      #if [
    elsif types[i] == 16
        @bracket = 1
        #skip [
        i=i+1

        @cond1 = Cond.new()
        i = @cond1.ParseCond(tokens, types, i)

        #if &&
        if types[i] == 18
          @andOr = 1
        #if ||
      elsif types[i] == 19
          @andOr = 2
        end

        #skip && or ||
        i=i+1

        @cond2 = Cond.new()
        i = @cond2.ParseCond(tokens, types, i)

        #skip ]
        i=i+1

      end
      i
    end

    def PrintCond
      if @comp
        @comp.PrintComp
      elsif @not == 1
        print "!"
        @cond1.PrintCond
      elsif @bracket == 1
        print "[ "
        @cond1.PrintCond
        if @andOr == 1
          print "&& "
        elsif @andOr == 2
          print "|| "
        end
        @cond2.PrintCond
        print "] "
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

    def ParseIf(tokens, types, i)
      #skip if token
      i=i+1

      @cond = Cond.new()
      i = @cond.ParseCond(tokens, types, i)

      #skip then token
      #i=i+1

      @ss1 = SS.new()
      i = @ss1.ParseSS(tokens, types, i)

      #skip ;
      #i=i+1

      if types[i] == 7
        #skip else
        #i=i+1

        @ss2 = SS.new()
        i = @ss2.ParseSS(tokens, types, i)

        #skip ;
        #i=i+1
      end

      #skip end
      i=i+1
    end

    def PrintIf(tab)
      print "If "
      @cond.PrintCond
      puts "then"
      @ss1.PrintSS(tab+1)

      if @ss2
        puts "else"
        @ss2.PrintSS(tab+1)
      end
      print "end "

    end

  end #end of If class

  #Loop class
  class Loop
    def initialize
      @cond
      @ss
    end

    def ParseLoop(tokens, types, i)
      #skip while
      i=i+1

      @cond = Cond.new()
      i = @cond.ParseCond(tokens, types, i)

      @ss = SS.new()
      i = @ss.ParseSS(tokens, types, i)

      #skip ;
      i=i+1

    end

    def PrintLoop(tab)
      print "while "
      @cond.PrintCond
      puts "loop"
      @ss.PrintSS(tab+1)
      print "\n"
      tab.times do
        print "\t"
      end
      print "end "
    end

  end #end of Loop class

  #IdList class
  class IdList
    def initialize
      @id
      @idList
    end

    def ParseIdList(tokens, types, i)
      @id = Id.new()
      i = @id.ParseId(tokens, types, i)

      if types[i] == 13
        #skip ,
        i=i+1

        @idList = IdList.new()
        i = @idList.ParseIdList(tokens, types, i)
      end
      i
    end

    def PrintIdList
      @id.PrintId
      if @idList
        @idList.PrintIdList
      end
    end

  end #end IdList class

  #In class
  class In
    def initialize
      @idList
    end

    def ParseIn(tokens, types, i)
      #skip read
      i=i+1

      @idList = IdList.new()
      i = @idList.ParseIdList(tokens, types, i)
    end

    def PrintIn
      print "read "
      @idList.PrintIdList
    end
  end #end of In class

  #Out class
  class Out
    def initialize
      @idList
    end

    def ParseOut(tokens, types, i)
      #skip write
      i=i+1

      @idList = IdList.new()
      i = @idList.ParseIdList(tokens, types, i)
    end

    def PrintOut
      print "write "
      @idList.PrintIdList
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

    def ParseStmt(tokens, types, i)
      #parses depending on statment type
      #if ID
      if types[i] == 32
        @assign = Assign.new()
        i = @assign.ParseAssign(tokens, types, i)

      #if If
      elsif types[i] == 5
          @if = If.new()
          i = @if.ParseIf(tokens, types, i)

      #if While
      elsif types[i] == 8
          @loop = Loop.new()
          i = @loop.ParseLoop(tokens, types, i)

      #if Read
      elsif types[i] == 10
          @in = In.new()
          i = @in.ParseIn(tokens, types, i)

      #if Write
      elsif types[i] == 11
          @out = Out.new()
          i = @out.ParseOut(tokens, types, i)
      end
      i
    end

    def PrintStmt(tab)
      if @assign
        @assign.PrintAssign
      elsif @if
        @if.PrintIf(tab)
      elsif @loop
        @loop.PrintLoop(tab)
      elsif @in
        @in.PrintIn
      elsif @out
        @out.PrintOut
      end

    end

  end #end Stmt class

  #SS class
  class SS
    def initialize
      @stmt
      @ss
    end

    def ParseSS(tokens, types, i)
      #skip begin
      i=i+1

      #if Assign or If or Loop or In or Out
      if(types[i] == 32 || types[i] == 5 || types[i] == 8 || types[i] == 10 || types[i] == 11)
        @stmt = Stmt.new()
        i = @stmt.ParseStmt(tokens, types, i)
        @ss = SS.new()
        i = @ss.ParseSS(tokens, types, i)
      end
      i
    end

    def PrintSS(tab)
      tab.times do
        print "\t"
      end

      if @stmt
        @stmt.PrintStmt(tab)
        puts ";"
      end

      if @ss
        @ss.PrintSS(tab)
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

    def ParseProg(tokens, types, i)
      #skip the program token
      #skip_token
      i=i+1

      @ds = DS.new()
      i = @ds.ParseDS(tokens, types, i)
      @ss = SS.new()
      i = @ss.ParseSS(tokens, types, i)
    end

    def PrintProg
      tab = 1
      puts "program"
      @ds.PrintDS(tab)
      puts "begin"
      @ss.PrintSS(tab)
      print "\n"
      puts "end"
    end
  end #end of Prog class

  def program(tokens, types, i)
    @program = Prog.new()
    x = @program.ParseProg(tokens, types, i)
    @program.PrintProg
  end

end #end of Parser class
