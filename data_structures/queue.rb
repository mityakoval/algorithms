# Implements First-In-First-Out Queue.
# Called `CQueue` to not interfere with Ruby's stdlib `Queue`.
# @author Mitya Koval
#
class CQueue
  include Enumerable

  # Creates a queue of a size specified by `n`
  # and fills it with integers from `0` to `n-1`.
  # If no parameter is passed creates an empty queue
  #
  # @param n [Integer] the size of the queue (defaults to `0`)
  #
  # @return [CQueue] an object of `CQueue` class
  #
  def initialize(n = 0)
    @elems = Array.new
    n.times.with_index { |i| self.enqueue i }
  end

  # Removes an element from the queue
  #
  # @return [Integer] the removed element
  #
  def dequeue
    @elems.pop
  end

  # Adds an element to the queue
  #
  # @param element [Integer] an element to be added to the queue
  #
  # @return [CQueue] the current object
  #
  def enqueue(element)
    @elems.unshift(element)
    self
  end

  # Returns the size of the queue
  #
  # @return [Integer] the size of the queue
  #
  def size
    @elems.size
  end

  # Yields passed block to the enumerator of the queue elements
  # to allow iterating directly on the queue object without accessing queue elements first
  #
  # @param block [Block] a block to be executed
  #
  # @return [Enumerator] which iterates over each element of the queue and yields it to the passed block
  #
  def each(&block)
    @elems.each {|el| block.call(el) }
  end

  #
  # Returns string representation of the queue
  #
  # @return [String] string representation of the queue
  def to_s
    @elems.to_s
  end

  # Indicates whether the queue is empty
  #
  # @return [true, false] whether the queue is empty
  def empty?
    @elems.empty?
  end
end
