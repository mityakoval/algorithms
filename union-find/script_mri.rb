require_relative 'percolation/percolation_stats_mri.rb'

n = ARGV[0].to_i
trials = ARGV[1].to_i

mc = PercolationStats.new(n, trials)

mc.print_results

