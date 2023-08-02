require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require 'date'

class Main
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
    puts 'Listing all books:'
    @books.each { |book| puts "#{book.title} by #{book.author}" }
  end

  def list_people
    puts 'Listing all people:'
    @people.each { |person| puts "#{person.class}: #{person.name} (ID: #{person.id})" }
  end

  def create_person
    puts 'Is the person a student or a teacher? (S/T)'
    person_type = gets.chomp.upcase

    if person_type == 'S'
      create_student
    elsif person_type == 'T'
      create_teacher
    else
      puts 'Invalid choice. Please enter "S" for student or "T" for teacher.'
    end
  end

  def create_student
    puts "Enter the student's first name:"
    first_name = gets.chomp
    puts "Enter the student's last name:"
    last_name = gets.chomp
    puts "Enter the student's age:"
    age = gets.chomp.to_i
    full_name = "#{first_name} #{last_name}"
    student = Student.new(generate_unique_id, age: age, name: full_name)
    @people << student
    puts "#{student.class} '#{student.name}' (ID: #{student.id}) has been created."
  end

  def create_teacher
    puts "Enter the teacher's first name:"
    first_name = gets.chomp
    puts "Enter the teacher's last name:"
    last_name = gets.chomp
    puts "Enter the teacher's age:"
    age = gets.chomp.to_i
    puts "Enter the teacher's specialization:"
    specialization = gets.chomp
    full_name = "#{first_name} #{last_name}"
    teacher = Teacher.new(generate_unique_id, specialization, age: age, name: full_name)
    @people << teacher
    puts "#{teacher.class} '#{teacher.name}' (ID: #{teacher.id}) has been created."
  end

  def create_book
    puts 'Enter the book title:'
    title = gets.chomp
    puts 'Enter the book author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts "Book '#{book.title}' by #{book.author} has been created."
  end

  def create_rental
    puts "Enter the person's ID who is renting the book:"
    person_id = gets.chomp.to_i
    person = find_person_by_id(person_id)
    if person.nil?
      puts "Person with ID #{person_id} not found."
      return
    end

    puts 'Enter the book title being rented:'
    book_title = gets.chomp
    book = find_book_by_title(book_title)
    if book.nil?
      puts "Book '#{book_title}' not found."
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
    puts 'Goodbye!'
    exit
  end

  private

  def generate_unique_id
    Time.now.to_i
  end

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end

  def find_book_by_title(title)
    @books.find { |book| book.title == title }
  end
end
