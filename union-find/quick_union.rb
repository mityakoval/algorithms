
#
# Implementation of `Quick union` algorithm for solving dynamic connectivity problem
#
# @author Mitya Koval
#
class QuickUnion

  #
  # Initializes the object and fills the indeces array with nodes `0` through `n-1`
  # @param n [Integer] describes the size of indeces array
  #
  def initialize(n)
    @id = Array.new(n) { |index| index }
  end

  #
  # Performs union operation by making `q` node's root `p` node's root as well
  # @param p [type] [description]
  # @param q [type] [description]
  #
  # @return [QuickUnion] returns the current object
  def union(p, q)
    i = root(p)
    j = root(q)
    @id[i] = j
    self
  end

  #
  # Checks whether two nodes are connected by comparing their roots
  # @param p [Integer] first node
  # @param q [type] second node
  #
  # @return [boolean] returns true or false depending on whether two nodes are connected
  def connected?(p, q)
    root(p) == root(q)
  end

  private
  # @private
  #
  # Seeks the root of a node `i` by chasing the roots of its parents
  # until `id[i]` equals `i` (`i` is its own root)
  #
  # @param i [Integer] the node for which the root needs to be found
  #
  # @return [type] the root of the `i-th` node
  def root(i)
    while (i != @id[i])
      i = @id[i]
    end
    return i
  end

end
