# create an array of students
students = [
{ name: "Dr. Hannibal Lecter", cohort: :november },
{ name: "Darth Vader", cohort: :november },
{ name: "Nurse Ratched", cohort: :november },
{ name: "Michael Corleone", cohort: :november },
{ name: "Alex DeLarge", cohort: :november },
{ name: "The Wicked Witch of the West", cohort: :november },
{ name: "Terminator", cohort: :november },
{ name: "Freddy Krueger", cohort: :november },
{ name: "The Joker", cohort: :november },
{ name: "Joffrey Baratheon", cohort: :november },
{ name: "Norman Bates", cohort: :november }
]

# print a header
def print_header
  puts "The Students of Villains Academy"
  puts "----------"
end

# print the students array elements
def print(students)
=begin # alternative code
  for student in students do
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
=end
  students.each_with_index do |student, number|
    puts "#{number}: #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

# finally we print the total in the footer
def print_footer(names)
  puts "Overall we have #{names.count} great students"
end

def input_students
  puts "Please enter the names of students"
  puts "To finish, just hit RETURN twice"

  #create an empty array
  students = []

  # get the first name
  name = gets.chomp

  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "now we have #{students.length} students..."
    # get another name
    name = gets.chomp
  end
  students
end

students = input_students
# call the methods
print_header
print(students)
print_footer(students)
