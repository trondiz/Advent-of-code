#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("day2/testss", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l.split(" ")
    i += 1
  end
end

n.each do |a|
  max = 0
  min = 9999
  a.each do |b|
    if b.to_i > max
      max = b.to_i
    end
    if b.to_i < min
      min = b.to_i
    end
  end
  puts "diff: #{max-min}"
  sum += max-min
end
puts "sum: #{sum}"
