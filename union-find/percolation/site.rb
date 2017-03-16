#
# Describes a single site in a percolation grid
#
# @author Mitya Koval
#
# @attr_reader [Integer] index of the site in the percolation grid
#
class Site
  attr_reader :index

  #
  # Initializes Site object with index within the grid and closed by default
  # @param index [Integer] index within the grid
  #
  # @return [Site] +Site+ object
  def initialize(index)
    @index = index
    @open = false
  end

  #
  # Checks whether the site is open
  #
  # @return [true || false] depending on whether the site is open or not
  def is_open?
    @open
  end

  #
  # Opens the site
  #
  # @return [Site] current object
  def open
    @open = true
    self
  end
end
