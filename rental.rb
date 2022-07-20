class Rental
  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals.push(self)
    person.rentals.push(self)
  end
  attr_accessor :date
  attr_reader :book, :person
end
