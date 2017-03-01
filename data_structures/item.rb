class Item
  attr_reader :value
  attr_reader :next_item

  def initialize(value, next_item = nil)
    @value = value
    @next = next_item
  end

  def add_next(item)

  end
end
