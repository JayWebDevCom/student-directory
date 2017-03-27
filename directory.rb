# create an array of students
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

# print a header
def print_header
  puts "The student of Villains Academy"
  puts "----------"
end

# print the students array elements
def print(names)
=begin # alternative code
  for name in names do
    puts names
  end
=end
  names.each do |name|
    puts name
  end
end

def print_footer(names)
  puts "Overall we have #{names.count} great students"
end

# finally we print the total


print_header
print(students)
print_footer(students)
