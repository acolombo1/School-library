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
      puts "Person created successfully.\n\n"
    when 2
      create_teacher
      puts "Person created successfully.\n\n"
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
    Teacher.new(name, age, specialization)
  end
end

def main
  item = 0
  app = App.new
  while item != 7
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person ID'
    puts '7 - Exit'
    item = gets.chomp.to_i
    choose(item, app)
  end
end

def choose(item, app)
  case item
  when 1
    app.list_all_books
  when 2
    app.list_all_people
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.list_rentals
  end
end

main
