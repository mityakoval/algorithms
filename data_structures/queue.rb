class CQueue
  include Enumerable

  def initialize(n = 0)
    @elems = Array.new
    n.times.with_index { |i| self.enqueue i }
  end

  def dequeue
    @elems.pop
  end

  def enqueue(element)
    @elems.unshift(element)
    self
  end

  def size
    @elems.size
  end

  def each(&block)
    @elems.each {|el| block.call(el) }
  end

  def elements
    @elems
  end

  def empty?
    @elems.empty?
  end
end
