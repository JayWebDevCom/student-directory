student_count = 11

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

# print the students array elements
puts "The student of Villains Academy"
puts "----------"

=begin
for student in students do
  puts student
end
=end

students.each do |student|
  puts student
end

# finally we print the total
puts "Overall we have #{students.count} great students"
