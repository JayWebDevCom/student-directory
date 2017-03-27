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

# define some Procs
letter = "T"
specific_letter = Proc.new { |student| student[:name].chr == letter }

name_length = 12
short_name = Proc.new { |student| student[:name].length <= name_length }

# use a while loop or until loop
count = 0
while count != students.length do
  puts "#{count+1} #{students[count][:name]} #{(students[count][:cohort])} cohort, hobby is #{(students[count][:hobby])}.".center(100)
  count += 1
end

end

# finally we print the total in the footer
def print_footer(names)
  puts "Overall we have #{names.count} great students.".center(100)
end

def input_students
  puts "To finish, just hit RETURN twice"

  #create an empty array
  students = []

  def get_name
    puts "Please enter the name of a student"
    name = gets.chomp
    #get_name if name.empty?
  end

  def get_cohort
    puts "Please enter the student cohort"
    cohort = gets.chomp
    #get_cohort if cohort.empty?
  end

  def get_hobby
    puts "Please enter the student hobby"
    hobby = gets.chomp
    #get_hobby if hobby.empty?
  end

  # get the name
  name = get_name
  # get the cohort
  cohort = get_cohort
  # get hobby info
  hobby = get_hobby

  while !name.empty? && !cohort.empty? && !hobby.empty? do
    # add the student hash to the array
    students << {name: name, cohort: cohort, hobby: hobby}
    puts "Now we have #{students.length} students..."

    # get the name
    name = get_name
    # get the cohort
    cohort = get_cohort
    # get hobby info
    hobby = get_hobby
  end
  students
end

students = input_students
# call the methods
print_header
print(students)
print_footer(students)
