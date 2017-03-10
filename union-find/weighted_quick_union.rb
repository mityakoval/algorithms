require_relative './quick_union.rb'
class WeightedQuickUnion < QuickUnion
  def initialize(n)
    super(n)
    @sizes = Array.new(n, 1)
  end

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
