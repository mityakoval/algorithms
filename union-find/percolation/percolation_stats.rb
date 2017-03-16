require_relative './percolation.rb'
# require 'ruby-progressbar'

class Time
  def to_ms
    (self.to_f * 1000.0).to_i
  end
end

#
# Runs Monte Carlo simulation to determine the percolation threshold of the percolation system
#
# @author Mitya Koval
#
class PercolationStats
  #
  # Initializes the PercolationStats object and runs the simulation
  # @param n [Integer] describes the size of +n x n+ grid
  # @param trials [Integer] amount of times to run the simulation
  #
  # @return [type] [description]
  def initialize(n, trials)
    raise ArgumentError.new("What's the point running an experiment #{trials} times? Please be wiser next time!") if trials <= 0
    raise ArgumentError.new("A grid with #{n} sites?! Really?!") if n <= 0
    @t = trials
    @thresholds = []
    print "Running Monte Carlo simulation\n"
    start = Time.now
    # bar = ProgressBar.create(:format => '%t: |%B| %p%%', total: trials, length: 80)
    trials.times do |i|
      mc = Percolation.new(n)
      while !mc.percolates?
        mc.open(rand(n), rand(n))
      end
      threshold = mc.open_sites / (n*n).to_f
      @thresholds << threshold
      # bar.increment
    end
    print "\n"
    finish = Time.now
    @time = finish.to_ms - start.to_ms
  end

  #
  # Calculates the mean based on amount of repetitions as an estimate of percolation threshold
  #
  # @return [Float] the mean
  def mean
    return @mean if @mean
    @mean = 0
    @thresholds.each { |t| @mean += t }
    @mean /= @t
  end

  #
  # Calculates the sample standard deviation as the measurement of the sharpness of the threshold
  #
  # @return [Float] the sample standard deviation
  def stddev
    return @stddev if @stddev
    @stddev = 0
    return if @t == 1
    @thresholds.each { |t| @stddev += (t - @mean)*(t - @mean) }
    @stddev /= @t - 1
    @stddev = @stddev
  end

  #
  # Calculates 95% confidence interval for the percolation threshold
  #
  # @return [Array<Float>] lowest(+[0]+) and highest(+[1]+) confidence leveles
  def confidence_interval
    return @confidence_interval if @confidence_interval
    @confidence_interval = []
    @confidence_interval << @mean - (1.96 * Math.sqrt(@stddev) / Math.sqrt(@t))
    @confidence_interval << @mean + (1.96 * Math.sqrt(@stddev) / Math.sqrt(@t))
  end

  #
  # Prints results of the simulation
  #
  def print_results
    puts "running time\t\t\t= #{@time / 1000.0}s"
    puts "mean\t\t\t\t= #{mean}"
    puts "stddev\t\t\t\t= #{stddev}"
    print "95% confidence interval\t\t= #{confidence_interval}\n"
  end
end
