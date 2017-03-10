class QuickFind

  def initialize(n)
    @id = Array.new(n) { |index| index }
    true
  end

  def union(p, q)
    return if p == q
    id_p = @id[p]
    id_q = @id[q]
    @id.map! { |item| item == id_p ? id_q : item }
  end

  def connected?(p, q)
    return true if p == q
    @id[p] == @id[q]
  end
end
