class TrimmerDecorator < Decorator
  def initialize(nameable)
    super(nameable)
    @nameable = nameable
  end

  def correct_name
    temp = @nameable.correct_name
    temp[0, 10] if temp.length > 10
  end
end
