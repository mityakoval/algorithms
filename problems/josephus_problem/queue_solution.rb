require_relative '../../data_structures/queue.rb'

begin
print 'Enter N: '
n = gets.chomp
if !n.match(/\d+/) or n.to_i == 0
  raise "N should be a number greater than 0"
end
n = n.to_i
print 'Enter M: '
m = gets.chomp
if !m.match(/\d/) or m.to_i == 0
  raise "N should be a number greater than 0"
end
m = m.to_i

q = CQueue.new(n)

i = 1
while !q.empty?
  puts "Round ##{i}: "
  0...(m-1).times do |el|
    q.enqueue(q.dequeue)
  end
  puts "#{q.dequeue}"
  puts "Remaining people: #{q}"
  i += 1
end

rescue Exception => e
  puts e.message
end
