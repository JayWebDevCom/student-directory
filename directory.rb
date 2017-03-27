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

def get_info(string)
  puts "Please enter the #{string} of the student"
  info = gets.chomp
  if string == 'cohort'
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    info = months[rand(11)] if info.empty?
  elsif string == 'hobby'
    info = "*unavailable*" if info.empty?
  end
  info
end

# finally we print the total in the footer
def print_footer(names)
  puts "Overall we have #{names.count} great students.".center(100)
  p names
end

def input_students
  puts "To finish, just hit RETURN three times"

  #create an empty array
  students = []

  # get the name
  name = get_info('name')

  # get the cohort
  cohort = get_info('cohort')

  #get the hobby
  hobby = get_info('hobby')


  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: cohort.intern, hobby: hobby}
    puts "Now we have #{students.length} students..."

    # get the name
    name = get_info('name')

    # get the cohort
    cohort = get_info('cohort')

    #get the hobby
    hobby = get_info('hobby')
  end
  students
end

students = input_students
# call the methods
print_header
print(students)
print_footer(students)
