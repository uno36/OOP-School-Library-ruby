# app.rb
require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require 'date'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @menu_options = {
      1 => method(:list_books),
      2 => method(:list_people),
      3 => method(:create_person),
      4 => method(:create_book),
      5 => method(:create_rental),
      6 => method(:list_rentals_for_person),
      7 => method(:quit_app)
    }
  end

  def list_books
    if @books.empty?
      puts 'There are no books in the system yet.'
    else
      puts 'Listing all books:'
      @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    end  
  end

  def list_people
    if @people.empty?
      puts 'There are no people in the system yet.'
    else
      puts 'Listing all people:'
      @people.each { |person| puts "[#{person.class}] #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    end  
  end

  def create_person
    puts 'Do you want to create a Student (1) or a Teacher (2)? [Input the number]:'
    person_type = gets.chomp.to_i

    if person_type == 1
      create_student
    elsif person_type == 2
      create_teacher
    else
      puts 'Invalid choice. Please enter (1) for student or (2) for teacher.'
    end
  end

  def create_student
    print "Age: "
    age = gets.chomp.to_i
    print "First Name: "
    first_name = gets.chomp
    print "Lats Name: "
    last_name = gets.chomp    
    full_name = "#{first_name} #{last_name}"
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp
    if parent_permission.downcase == 'n'
      student = Student.new(generate_unique_id, age: age, parent_permission: false, name: full_name)
    elsif parent_permission.downcase == 'y'
      student = Student.new(generate_unique_id, age: age, parent_permission: true, name: full_name)
    else
      puts 'Invalid Selection for parent permission'
      return
    end
    student = Student.new(generate_unique_id, age: age, name: full_name)
    @people << student
    puts 'Person created successfully'
  end

  def create_teacher
    print "Age: "
    age = gets.chomp.to_i
    print "First Name: "
    first_name = gets.chomp
    print "Last Name: "
    last_name = gets.chomp    
    print "Specialization:"
    specialization = gets.chomp
    full_name = "#{first_name} #{last_name}"
    teacher = Teacher.new(generate_unique_id, specialization, age: age, name: full_name)
    @people << teacher
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a person from the list by number (not id):'
    list_people_with_numbers

    person_number = gets.chomp.to_i
    person = find_person_by_number(person_number)

    if person.nil?
      puts "Person with number #{person_number} not found."
      return
    end

    puts 'Select a book from the list by number:'
    list_books_with_authors

    book_number = gets.chomp.to_i
    book = find_book_by_author(book_number)

    if book.nil?
      puts "Book with number #{book_number} not found."
      return
    end

    puts 'Enter the rental date (YYYY-MM-DD):'
    rental_date = gets.chomp
    rental = Rental.new(Date.parse(rental_date), book, person)
    @rentals << rental
    puts "#{person.class} '#{person.name}' (ID: #{person.id}) has rented '#{book.title}' (ID: #{book.object_id})."
  end

  def list_rentals_for_person
    puts "Enter the person's ID to list rentals:"
    person_id = gets.chomp.to_i
    person = find_person_by_id(person_id)
    if person.nil?
      puts "Person with ID #{person_id} not found."
      return
    end

    puts "Rentals for #{person.class} '#{person.name}' (ID: #{person.id}):"
    rentals = @rentals.select { |rental| rental.person == person }
    rentals.each do |rental|
      puts "'#{rental.book.title}' (ID: #{rental.book.object_id}) - Rental Date: #{rental.date}"
    end
  end

  def list_people_with_numbers
    @people.each_with_index do |person, index|
      puts "#{index + 1}. #{person.class}: #{person.name} (ID: #{person.id})"
    end
  end

  def list_books_with_authors
    @books.each_with_index do |book, index|
      puts "#{index + 1}. #{book.title} by #{book.author}"
    end
  end

  def display_menu
    puts 'Menu Options:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
    puts 'Enter the option number:'
  end

  def run
    puts 'Welcome to the Library App!'
    loop do
      display_menu
      option = gets.chomp.to_i

      if @menu_options.key?(option)
        @menu_options[option].call
      else
        puts 'Invalid option. Please try again.'
      end
    end
  end

  def quit_app
    puts 'Thank you for using this App, Goodbye!'
    exit
  end

  private

  def generate_unique_id
    Time.now.to_i
  end

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end

  def find_person_by_number(number)
    @people[number - 1] if number.between?(1, @people.length)
  end

  def find_book_by_author(book_number)
    @books[book_number - 1] if book_number.between?(1, @books.length)
  end
end

def main
  app = App.new
  app.run
end

main
