#!/usr/bin/ruby -w
require 'date'
start = DateTime.now.strftime('%Q').to_i

n = 366

# Part 1
cir_buf = Array.new
cir_buf << 0
cur_pos=0
length = 1
for i in 1..2017
  cir_buf.insert((cur_pos + n) % length+1, i)
  cur_pos = (cur_pos + n) % length+1
  length += 1
end
p1 = cir_buf[cir_buf.index(2017)+1]
puts "Part 1: #{p1}"

# Part 2
# We can skip using the array at all for part 2
cur_pos=0
length = 1
p2=0
for i in 1..50000000
  cur_pos = (cur_pos + n) % length+1
  if cur_pos == 1
    p2 = i
  end
  length += 1
end

puts "Part 2: #{p2}"
puts "Time: #{DateTime.now.strftime('%Q').to_i - start}ms"
