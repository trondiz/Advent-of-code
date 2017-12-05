#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l.to_i
    i += 1
  end
end

s = 0
while true do
  # tmp
  tmp = s
  # Jump to
  s += n[s]
  #increase or decrease
  if n[tmp] >= 3
    n[tmp] -=1
  else
    n[tmp] +=1
  end
  sum +=1
  if s > n.length-1 || s < 0
    break
  end
end
puts "Sum: #{sum}"

