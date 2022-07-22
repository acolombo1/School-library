require './nameable'
require './decorator'
require './trimmer_decorator'
require './capitalize_decorator'
require './person'
require './student'
require './teacher'
require './book'
require './classroom'
require './rental'

class App
  def list_all_books
    ObjectSpace.each_object(Book) { |book| print "Title: #{book.title}, Author: #{book.author}\n" }
    puts 'No books loaded.' if ObjectSpace.each_object(Book).count.zero?
    puts "\n"
  end

  def list_all_people
    ObjectSpace.each_object(Person) do |person|
      if person.instance_of?(Teacher)
        print "[Teacher] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}\n"
      elsif person.instance_of?(Student)
        print "[Student] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}\n"
      else
        print "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}\n"
      end
    end
    puts 'No people loaded.' if ObjectSpace.each_object(Person).count.zero?
    puts "\n"
  end

  def create_person
    puts 'Do you want to create a Student (1) or a Teacher (2)? [Input number]:'
    item = gets.chomp.to_i
    case item
    when 1
      create_student
      puts "Student created successfully.\n\n"
    when 2
      create_teacher
      puts "Teacher created successfully.\n\n"
    else
      puts "No person created :(\n\n"
    end
  end

  def create_student
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    pp = ''
    while pp != 'Y' && pp != 'N'
      print 'Has parent permission [y/n]: '
      pp = gets.chomp.upcase
    end
    parent_permission = true if pp == 'Y'
    parent_permission = false if pp == 'N'
    Student.new(name, age, parent_permission: parent_permission)
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    Teacher.new(name, specialization, age)
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    Book.new(title, author)
    puts "Book created successfully.\n\n"
  end

  def list_rentals
    print 'ID of person: '
    person_id = gets.chomp
    rentals = ObjectSpace.each_object(Rental).select { |rental| rental.person.id.to_i == person_id.to_i }

    rentals.each { |rental| print "Date: #{rental.date}, Book: #{rental.book.title}\n" }
    puts 'No rentals.' if rentals == []
    puts "\n"
  end

  def create_rental
    if ObjectSpace.each_object(Book).count.zero?
      puts "No books loaded.\n\n"
      return nil
    end
    if ObjectSpace.each_object(Person).count.zero?
      puts "No people loaded.\n\n"
      return nil
    end
    list_books
    book_obj = read_book
    return nil if book_obj.nil?

    list_persons
    person_obj = read_person
    return nil if person_obj.nil?

    print 'Date: '
    date = gets.chomp
    Rental.new(date, book_obj, person_obj)
    puts "Rental created successfully.\n\n"
  end

  private

  def list_books
    puts 'Select book from the following list number:'
    ObjectSpace.each_object(Book).with_index do |book, index|
      print "#{index}) Title: #{book.title}, Author: #{book.author}\n"
    end
  end

  def read_book
    book_nr = gets.chomp.to_i
    book_obj = ObjectSpace.each_object(Book).with_index.find { |_book, index| index == book_nr }
    if book_obj.nil?
      puts "No book with that number :(\n\n"
      return nil
    end
    book_obj[0]
  end

  def list_persons
    puts 'Select person from the following list number (not ID):'
    ObjectSpace.each_object(Person).with_index do |person, index|
      if person.instance_of?(Teacher)
        print "#{index}) [Teacher] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}\n"
      elsif person.instance_of?(Student)
        print "#{index}) [Student] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}\n"
      end
    end
  end

  def read_person
    person_nr = gets.chomp.to_i
    person_obj = ObjectSpace.each_object(Person).with_index.find { |_person, index| index == person_nr }
    if person_obj.nil? || (!person_obj[0].instance_of?(Teacher) && !person_obj[0].instance_of?(Student))
      puts "No Student or Teacher with that number :(\n\n"
      return nil
    end
    person_obj[0]
  end
end
