#
# Implementation of `Quick find` algorithm to solve dynamic connectivity problem
#
# @author Mitya Koval
class QuickFind

  #
  # Initializes an object and fills the indeces array with nodes 0 through n-1
  # @param n [Integer] describes the size of 'indeces' array for the algorithm
  #
  def initialize(n)
    @id = Array.new(n) { |index| index }
  end

  #
  # Performes union operation of two nodes by changing all entries whose id equals id[p] to id[q]
  # @param p [Integer] first node
  # @param q [Integer] second node
  #
  # @return [QuickFind] returns the current object
  def union(p, q)
    return if p == q
    id_p = @id[p]
    id_q = @id[q]
    @id.map! { |item| item == id_p ? id_q : item }
    self
  end

  #
  # Checks whether two nodes are connected
  # @param p [Integer] first node
  # @param q [Integer] second node
  #
  # @return [boolean] returns true or false depending on whether two nodes are connected
  def connected?(p, q)
    return true if p == q
    @id[p] == @id[q]
  end
end
