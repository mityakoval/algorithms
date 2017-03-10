class Site
  attr_reader :index

  def initialize(index)
    @index = index
    @open = false
  end

  def is_open?
    @open
  end

  def open
    @open = true
  end

  def is_full?
    !@open
  end
end
