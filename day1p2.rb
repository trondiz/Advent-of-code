#!/usr/bin/ruby

a =  ARGV[0].split(//)
sum = 0
step = a.length/2
a.each_with_index do |val, i|
  if a[i] == a[(i+step)%a.length]
    sum += val.to_i
  end
end
puts sum
