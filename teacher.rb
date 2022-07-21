class Teacher < Person
  def initialize(name, specialization, age = 'Unknown')
    super(name, age, true)
    @specialization = specialization
  end
  attr_accessor :specialization

  def can_use_services?
    true
  end
end
