require 'csv'
# create an array of students
@students = []
ARGV.any? ? @filename = ARGV.first : @filename = 'students.csv'
# cohort accepted months
@months_array = %w[january february march april may june july august september october november december]
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
    puts "#{count+1}: #{@students[count][:name]} #{(@students[count][:cohort])} cohort and hobby is #{(@students[count][:hobby])}.".center(75)
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
  puts "3 > Save the list of students"
  puts "4 > Load a list of students"
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
        puts ">< #{show_decision(selection)}: Input students ><"
        puts ">< You are now about to enroll some students for Villains Academy ><"
        puts "To finish, just hit RETURN three times"
        new_line
        input_students(filename = @filename)
      when "2"
        new_line
        puts ">< #{show_decision(selection)}: Show students ><"
        puts ">< The following are listed for Villains Academy ><"
        new_line
        show_students
      when "3"
        new_line
        puts ">< #{show_decision(selection)}: Save students ><"
        new_line
        ask_save_message
      when "4"
        new_line
        puts ">< #{show_decision(selection)}: Load students ><"
        new_line
        ask_load_message
      when "9"
        puts "Goodbye..."
        exit
      else
        puts "Please try again"
      end
end

def save_students(filename = @filename)
  if File.exists?(filename)
      save_to_csv(filename)
    puts ">< Save Successful ><"
  else
    puts "Sorry, #{filename} doesn't exist"
  end
end

def input_students(filename = @filename)
    get_three_info('name', 'cohort', 'hobby')
  while !@name.empty? do
      @students << {name: @name, cohort: @cohort, hobby: @hobby}
    puts "Now we have #{@students.length} #{@students.length == 1 ? 'student' : 'students'}"
    get_three_info('name', 'cohort', 'hobby')
  end
end

def interactive_menu
  loop do
    print_menu
    selection = STDIN.gets.chomp
    process(selection)
  end
end

def load_students(filename = @filename)

  if File.exists?(filename)
      @students = []
    assign_student_info(filename)
    puts "Successfully loaded #{@students.count} #{@students.count == 1 ? 'student' : 'students'} from #{@filename}"
  else
    puts "Unable to locate #{filename}"
  end
end

def try_load_students()
    if File.exists?(@filename)
      load_students()




    else
      puts "Sorry, #{@filename} doesn't exist"
      exit
    end
end

def assign_student_info(filename)

    count = 0
  CSV.foreach(filename) do |row|
    @students << {name: row[0], cohort: row[1].to_sym, hobby: row[2]}
    count += 1
  end

end

def get_three_info(name, cohort, hobby)
  @name = get_info('name')
  @cohort = get_info('cohort').downcase
  @hobby = get_info('hobby')
end

# method to print students by cohort grouping
def print_students_by_cohort()
 @students.group_by {|student| student[:cohort]}.each { |month, value|
	      puts "#{month.capitalize}: #{value.size} student(s)"
		      value.each { |student|
			      puts student[:name]
		      }
	      }
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

def ask_save_message
    print_save_menu
    file_selection = STDIN.gets
    process_save_instructions(file_selection.delete("\n"))
end

def ask_load_message
    print_load_menu
    file_selection = STDIN.gets
    process_load_instructions(file_selection.delete("\n"))
end

def print_load_menu
  puts "What would you like to do?"
  puts "1 > Load from default file #{@filename}"
  puts "2 > Specify a different file to load from"
  puts "9 > Return to main menu"
end

def print_save_menu
  puts "What would you like to do?"
  puts "1 > Save to a default file #{@filename}"
  puts "2 > Specify a different file to save to"
  puts "9 > Return to main menu"
end

def process_save_instructions(file_selection)
  case file_selection
  when "1"
    save_students(@filename)
  when "2"
    puts "Please enter the filename to save to"
    entry = get_entry()
    save_students(entry)
  when "9"
    interactive_menu
  else
    puts "Please try again"
  end
end

def process_load_instructions(file_selection)
  case file_selection
  when "1"
    load_students(@filename)
  when "2"
    puts "Please enter the filename to load from"
    entry = get_entry()
    load_students(entry)
  when "9"
    interactive_menu
  else
    puts "Please try again"
  end
end

def show_decision(selection)
  "You chose \"#{selection}\""
end

def save_to_csv(filename)
  CSV.open(filename, 'w') do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort], student[:hobby]]
    end
  end
end

def get_entry()
  entry = STDIN.gets.delete("\n")
end

try_load_students()
interactive_menu
