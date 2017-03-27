# create an array of students
students = [
  ["Dr. Hannibal Lecter", :november],
  ["Darth Vader", :november],
  ["Nurse Ratched", :november],
  ["Michael Corleone", :november],
  ["Alex DeLarge", :november],
  ["The Wicked Witch of the West", :november],
  ["Terminator", :november],
  ["Freddy Krueger", :november],
  ["The Joker", :november],
  ["Joffrey Baratheon", :november],
  ["Norman Bates", :november]
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
    puts "#{student[0]} (#{student[1]} cohort)"
  end
=end
  students.each do |student|
    puts "#{student[0]} (#{student[1]} cohort)"
  end
end

# finally we print the total in the footer
def print_footer(names)
  puts "Overall we have #{names.count} great students"
end

# call the methods
print_header
print(students)
print_footer(students)
