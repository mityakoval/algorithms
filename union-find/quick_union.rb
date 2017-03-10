class QuickUnion
  def initialize(n)
    @id = Array.new(n) { |index| index }
  end

  def union(p, q)
    i = root(p)
    j = root(q)
    @id[i] = j
  end

  def connected?(p, q)
    root(p) == root(q)
  end

  private

  def root(i)
    while (i != @id[i])
      i = @id[i]
    end
    return i
  end

end
