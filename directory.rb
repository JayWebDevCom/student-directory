# create an array of students
@students = []
ARGV.any? ? @filename = ARGV.first : @filename = 'students.csv'
# cohort accepted months
@months_array = %w[january, february, march, april, may, june, july, august, september, october, november, december]
# constant for displaying students by hash key
@symbol = 'cohort'
# constant for displaying a particular cohort of students
@cohort_to_search = 'april'
# constant for displaying students with names that start with
@letter = "T"
# constant for displaying students with names at most this long
@name_length = 10

# print a header
def print_header
  puts "The Students of Villains Academy"
  puts ">< >< >< >< >< >< >< >< >< >< >< "
end

def print_students_list()
  count = 0
  while count != @students.length do
    puts "#{count+1}: #{@students[count][:name]} #{(@students[count][:cohort])} cohort, hobby is #{(@students[count][:hobby])}.".center(75)
    count += 1
  end
end

# get name, get cohort, get hobby extracted into one method
def get_info(string)
  puts "Please enter the #{string} of the student"
  info = STDIN.gets.delete("\n")
  if string == 'cohort'
    info = @months_array[rand(11)] if !@months_array.include?(info.downcase)
  elsif string == 'hobby'
    info = "*unavailable*" if info.empty?
  end
  info
end

# method to print name and cohort or anyother symbol
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
def print_by_month()
  that_cohort = Proc.new { |student| student[:cohort] == @cohort_to_search.downcase.intern }
  @students.select(&that_cohort).each { |student|
	  puts "Name: #{student[:name]}, Month: #{student[:cohort]}"
  }
end

# finally we print the total in the footer
def print_footer()
  if @students.count > 0
    puts "Overall we have #{@students.count} great #{@students.count == 1 ? 'student' : 'students'}.".center(75)
  else
    puts "No students to show".center(75)
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
  new_line
  puts "Please choose your evil action"
  puts "1 > Input the students"
  puts "2 > Show the students"
  puts "3 > Save the list to #{@filename}"
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
        new_line
        puts ">< You chose \"#{selection}\": Input students ><"
        puts ">< You are now about to enroll some students for Villains Academy ><"
        puts "To finish, just hit RETURN three times"
        input_students
      when "2"
        new_line
        puts ">< You chose \"#{selection}\": Show students ><"
        puts ">< The following are listed for Villains Academy ><"
        new_line
        show_students
      when "3"
        new_line
        puts ">< You chose \"#{selection}\": Save students ><"
        puts ">< The following are listed for Villains Academy ><"
        new_line
        save_students
      when "4"
        new_line
        puts ">< You chose \"#{selection}\": Load students ><"
        puts ">...><"
        new_line
        load_students
      when "9"
        puts "Goodbye..."
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
  puts ">< Save Successful ><"
  out_file.close
end

def input_students
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
    if File.exists?(@filename)
      load_students()
      puts "Successfully loaded #{@students.count} #{@students.count == 1 ? 'student' : 'students'} from #{@filename}"
    else
      puts "Sorry, #{@filename} doesn't exist"
      exit
    end
end

def assign_student_info
  @students << {name: @name, cohort: @cohort.intern.downcase, hobby: @hobby}
end

def get_three_info(name, cohort, hobby)
  @name = get_info('name')
  @cohort = get_info('cohort')
  @hobby = get_info('hobby')
end

def print_students_list_by_letter()
  short_name = Proc.new { |student| student[:name].length <= @name_length }
    to_get = @students.select(&short_name)
  count = 0
  p to_get
end

def new_line
  puts "\n"
end

try_load_students()
interactive_menu
