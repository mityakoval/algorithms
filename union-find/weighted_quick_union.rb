require_relative './quick_union.rb'

#
# Implementaion of 'Weighted quick union' algorithm to solve dynamic connectivity problem
# Improved efficiency compared to standard quick union by balancing the trees heights and making sure
# that smaller trees are included into larger trees and not vice versa.
#
# @author Mitya Koval
#
class WeightedQuickUnion < QuickUnion

  #
  # Instantiates a new object of the class (see {QuickUnion#initialize}).
  # Additionaly creates
  # @param n [Integer] describes the size of the indeces array
  #
  def initialize(n)
    super(n)
    @sizes = Array.new(n, 1)
  end

  #
  # Performs union operation of two trees. First tree with root of `p-th` node and second tree with root of `q-th` tree.
  # Checks which one of them is smaller and adds it to the larger one.
  # @param p [type] first node
  # @param q [type] second node
  #
  # @return [WeightedQuickUnion] returns the currrent object
  def union(p, q)
    i = root(p)
    j = root(q)
    return if i == j
    if @sizes[i] < @sizes[j]
      @id[i] = j
      @sizes[j] += @sizes[i]
    else
      @id[j] = i
      @sizes[i] += @sizes[j]
    end
    self
  end
end
