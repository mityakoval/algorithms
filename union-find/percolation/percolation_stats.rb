require_relative './percolation.rb'
require 'ruby-progressbar'

class Time
  def to_ms
    (self.to_f * 1000.0).to_i
  end
end

class PercolationStats
  def initialize(n, trials)
    @t = trials
    @n = n
    @threshholds = []
    print "Running Monte Carlo experiment\n"
    start = Time.now
    bar = ProgressBar.create(:format => '%t: |%B| %p%%', total: trials, length: 80)
    trials.times.with_index do |t, i|
      mc = Percolation.new(n)
      while !mc.percolates?
        mc.open(rand(n), rand(n))
      end
      threshhold = mc.open_sites / (n*n).to_f
      @threshholds << threshhold
      bar.increment
    end
    print "\n"
    finish = Time.now
    @time = finish.to_ms - start.to_ms
  end

  def mean
    return @mean if @mean
    @mean = 0
    @threshholds.each { |t| @mean += t }
    @mean /= @t
  end

  def stddev
    return @stddev if @stddev
    @stddev = 0
    @threshholds.each { |t| @stddev += (t - @mean)*(t - @mean) }
    @stddev /= @t - 1
    @stddev = @stddev
  end

  def confidence_interval
    return @confidence_interval if @confidence_interval
    @confidence_interval = []
    @confidence_interval << @mean - (1.96 * Math.sqrt(@stddev) / Math.sqrt(@t))
    @confidence_interval << @mean + (1.96 * Math.sqrt(@stddev) / Math.sqrt(@t))
  end

  def print_results
    puts "running time\t\t\t= #{@time} ms"
    puts "mean\t\t\t\t= #{mean}"
    puts "stddev\t\t\t\t= #{stddev}"
    print "95% confidence interval\t\t= #{confidence_interval}\n"
  end
end
