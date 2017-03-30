# a file that reads its own source code

# this is my source code. Hello!

# I have a method called Fizzbuz()
def fizzbuzz(number)

  if number % 5 == 0 && number % 3 == 0
  	"FizzBuzz"
  elsif number % 5 == 0
  	"Buzz"
  elsif number % 3 == 0
  	"Fizz"
  else
  	number
  end
end

for number in (1..30) do
	puts "#{number} #{fizzbuzz(number)}"
end

#puts open(__FILE__).read
puts open($0).read
