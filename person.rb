class Person < Nameable
  def initialize(name, age = 'Unknown', parent_permission: true)
    super(self)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  attr_reader :id, :parent_permission
  attr_accessor :name, :age, :rentals

  def correct_name
    @name
  end

  def can_use_services?
    true if is_of_age || @parent_permission
    false
  end

  def add_rental(book, date)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    true if @age >= 18
    false
  end
end
