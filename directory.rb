# create an array of students
@students = []
ARGV.any? ? @filename = ARGV.first : @filename = 'students.csv'

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
def print_students_list()

  # define some Procs
  letter = "T"
  specific_letter = Proc.new { |student| student[:name].chr == letter }

  name_length = 12
  short_name = Proc.new { |student| student[:name].length <= name_length }

  # use a while loop or until loop
  count = 0
  while count != @students.length do
    puts "#{count+1}: #{@students[count][:name]} #{(@students[count][:cohort])} cohort, hobby is #{(@students[count][:hobby])}.".center(100)
    count += 1
  end

end

def get_info(string)
  puts "Please enter the #{string} of the student"

  # use .delete("\n") in place of .chomp
  info = STDIN.gets.delete("\n")
  if string == 'cohort'
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    info = months[rand(11)] if !months.include?(info.downcase)
  elsif string == 'hobby'
    info = "*unavailable*" if info.empty?
  end
  info
end

# method to print name and cohort or anyother symbol
@symbol = 'cohort'
def print_by_symbol()
to_get = @students.map{ |student| student[@symbol.intern] }
to_get.sort.each { |get|
	@students.each { |student|
	  p "#{@symbol.capitalize}: #{student[@symbol.intern]}   Name:#{student[:name]}" if student[@symbol.intern] == get
	  # not centered because it is easier to read when left justified
	}
}
end

# method to print name and cohort by any month
@month = 'november'
def print_by_month()
  that_cohort = Proc.new { |student| student[:cohort] == @month.downcase.intern }
  @students.select(&that_cohort).each { |student|
	  puts "Name: #{student[:name]}, Month: #{student[:cohort]}"
  }
end

# finally we print the total in the footer
def print_footer()
  if @students.count > 0
    puts "Overall we have #{@students.count} great #{@students.count == 1 ? 'student' : 'students'}.".center(100)
  else
    puts "No students to show".center(100)
  end
end



def interactive_menu
  loop do
    print_menu
    selection = STDIN.gets.chomp
    process(selection)
  end
end

def print_menu()
  puts "1 > Input the students"
  puts "2 > Show the students"
  puts "3 > Save the list #{@filename}"
  puts "4 > Load the list of students from #{@filename}"
  puts "9 > Exit"
end

def show_students()
  print_header()
  print_students_list()
  print_footer()
end

def process(selection)
    case selection
      when "1"
        students = input_students
      when "2"
        show_students
      when "3"
        save_students
      when "4"
        load_students
      when "9"
        exit
      else
        puts "Please try again"
      end
end

def save_students()
  out_file = File.open(@filename, 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby]]
    csv_line = student_data.join(',')
    out_file.puts csv_line
  end
  out_file.close
end

def input_students
  puts "To finish, just hit RETURN three times"
    get_three_info('name', 'cohort', 'hobby')
  while !@name.empty? do
      assign_student_info
    puts "Now we have #{@students.length} #{@students.length == 1 ? 'student' : 'students'}"
    get_three_info('name', 'cohort', 'hobby')
  end
end

def load_students()
  in_file = File.open(@filename, 'r')
  in_file.readlines.each do |line|
    @name, @cohort, @hobby = line.chomp.split(',')
      assign_student_info
  end
  in_file.close
end

def try_load_students()
  #@return if filename.nil?
    if File.exists?(@filename)
      load_students()
      puts "Successfully loaded #{@students.count} #{@students.count == 1 ? 'student' : 'students'} from #{@filename}"
    else
      puts "Sorry, #{@filename} doesn't exist"
      exit
    end
end

def assign_student_info
  @students << {name: @name, cohort: @cohort.intern, hobby: @hobby}
end

def get_three_info(name, cohort, hobby)
  @name = get_info('name')
  @cohort = get_info('cohort')
  @hobby = get_info('hobby')
end

try_load_students()
interactive_menu()
