require '../weighted_quick_union.rb'
require '../quick_union.rb'
require './site.rb'
class Percolation
  attr_reader :open_sites

  def initialize(n)
    @grid = Array.new(n) { |i| Array.new(n) { |j| Site.new(((n-1) * i) + j + i) } }
    @open_sites = 0
    @virtual_top_id = n*n
    @virtual_bottom_id = n*n + 1
    @wqu = WeightedQuickUnion.new(n*n + 2)
    n.times.with_index do |i| # connect top and bottom rows of the grid to the virtual sites
      @wqu.union(i, @virtual_top_id) # connect grid[0][i] to virtual top site (i < n)
      @wqu.union((n*n - n + i), @virtual_bottom_id) # connect grid[n-1][i] to virtual bottom site (i < n)
    end
  end

  def open(row, col)
    site = @grid[row][col]
    return if site.is_open?
    site.open
    @open_sites += 1
    connect_neighbour(site, row - 1, col)
    connect_neighbour(site, row + 1, col)
    connect_neighbour(site, row, col - 1)
    connect_neighbour(site, row, col + 1)
  end

  def is_open?(row, col)
    @grid[row][col].is_open?
  end

  def is_full?(row, col)
    @grid[row][col].is_full?
  end

  def percolates?
    return @wqu.connected?(@virtual_top_id, @virtual_bottom_id)
  end

  def show_grid
    @grid.each.with_index do |row, row_i|
      row.each.with_index do |site, col_i|
        print "#{site.is_open? ? 1 : 0} "
        if col_i < @grid.size - 1
          right_site = @grid[row_i][col_i + 1]
          print "#{@wqu.connected?(site.index, right_site.index) ? '-' : ' '}"
        end
        print " "
      end
      print "\n"
      row.each.with_index do |site, col_i|
        if row_i < @grid.size - 1
          bottom_site = @grid[row_i + 1][col_i]
          print "#{@wqu.connected?(site.index, bottom_site.index) ? '|' : ' '}   "
        end
      end
      print "\n"
    end
  end

  private

  def connect_neighbour(site, nb_row, nb_col)
    if (nb_row >= 0 and nb_row < @grid.size ) and (nb_col >= 0 and nb_col < @grid.size )
      neighbour = @grid[nb_row][nb_col]
      @wqu.union(site.index, neighbour.index) if neighbour.is_open?
    end
  end
end
