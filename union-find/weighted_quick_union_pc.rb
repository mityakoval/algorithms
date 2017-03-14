require_relative './weighted_quick_union.rb'

#
# Implementation of `Quick union with path compression` algorithm for solving dynamic connectivity problem
# In addition to the approach of 'Weighted quick union' this algorithm flattens the tree on each `root` operation
#
# @author Mitya Koval
#
class WeightedQuickUnionPc < WeightedQuickUnion

  #
  # Seeks the root of the `i-th` node and flattens the tree that contains `i-th` node
  # @param i [Integer] node
  #
  # @return [Integer] root of the `i-th` node
  def root(i)
    while (i != @id[i])
      @id[i] = @id[@id[i]]
      i = @id[i]
    end
    return i
  end

end
