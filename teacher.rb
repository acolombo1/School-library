class Teacher < Person
  def initialize(name, specialization, age = 'Unknown')
    super(name, age, parent_permission: true)
    @specialization = specialization
  end
  attr_accessor :specialization

  def can_use_services?
    true
  end
end
