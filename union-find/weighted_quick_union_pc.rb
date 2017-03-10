require_relative './weighted_quick_union.rb'

#
# Quick union with path compression algorithm
#
# @author Mitya Koval
#
class WeightedQuickUnionPc < WeightedQuickUnion
  def initialize(n)
    super(n)
  end

  def root(i)
    while (i != @id[i])
      @id[i] = @id[@id[i]]
      i = @id[i]
    end
    return i
  end
end
