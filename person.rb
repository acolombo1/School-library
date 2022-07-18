class Person
  def initialize(name, age = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end
  attr_reader :id
  attr_accessor :name, :age

  private

  def of_age?
    true if @age >= 18
    false
  end

  def can_use_services?
    true if is_of_age || @parent_permission
    false
  end
end
