class Test

	def initialize()
		@x = 1
		@y = 2
		@z = 0
	end

	def show
		puts @x 
		puts @y
		puts @z
	end

	def right
		@z = @x + @y
	end

end

x = Test.new()

x.right

puts x.show
