# include Java
require_relative '../weighted_quick_union_pc.rb'
require_relative './site.rb'
# require '/usr/local/algs4/algs4.jar'

#
# Implementation of percolation system
#
# @author Mitya Koval
# @attr_reader [Array<Integer>] open_sites amount of open sites in the percolation grid
#
class Percolation
  attr_reader :open_sites

  #
  # Initializes Percolation object, creates the grid and fills it with sites assigning an index from +0+ to +n-1+.
  # Creates WeightedQuickUnion object with top and bottom virtual sites
  # and connects them to the top and bottom rows of the grid respectively.
  # @param n [Integer] describes the size of one dimension of the grid
  #
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

  #
  # Opens a site in the grid and connects it to the neighbouring open sites
  # @param row [Integer] the row that holds the site
  # @param col [Integer] the column that holds the site
  #
  # @return [Percolation] returns current object
  def open(row, col)
    site = @grid[row][col]
    return if site.is_open?
    site.open
    @open_sites += 1
    connect_neighbour(site, row - 1, col)
    connect_neighbour(site, row + 1, col)
    connect_neighbour(site, row, col - 1)
    connect_neighbour(site, row, col + 1)
    self
  end

  #
  # Checks whether a certain site is open
  # @param row [type] the row that holds the site
  # @param col [type] the column that holds the site
  #
  # @return [true || false] depending on whether the site is open
  def is_open?(row, col)
    @grid[row][col].is_open?
  end

  #
  # Checks whether a certain site is connected to the top of the grid
  # @param row [type] the row that holds the site
  # @param col [type] the column that holds the site
  #
  # @return [true || false] depending on whether the site is connected to the top
  def is_full?(row, col)
    site = @grid[row][col]
    @wqu.connected?(@virtual_top_id, site.index)
  end

  #
  # Checks whether the system percolates, e.g. whether there is a path from top to bottom through open sites
  #
  # @return [true || false] depending on whether the system percolates
  def percolates?
    return @wqu.connected?(@virtual_top_id, @virtual_bottom_id)
  end

  #
  # Prints the grid with connections between sites
  #
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
    nil
  end

  private

  #
  # @private
  # Connects two open sites
  # @param site [Site] the first site to connect
  # @param nb_row [Integer] row that holds the second site
  # @param nb_col [Integer] column that holds the second site
  #
  def connect_neighbour(site, nb_row, nb_col)
    # check that neighbour coordinates are not outside of the grid
    if (nb_row >= 0 and nb_row < @grid.size ) and (nb_col >= 0 and nb_col < @grid.size )
      neighbour = @grid[nb_row][nb_col]
      @wqu.union(site.index, neighbour.index) if neighbour.is_open?
    end
  end
end
