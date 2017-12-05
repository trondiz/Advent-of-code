#!/usr/bin/ruby

a =  ARGV[0].split(//)
sum = 0
a.each_with_index do |val, i|
  if a.length == i+1 && a[i] == a[0]
    sum += val.to_i
  elsif a[i] == a[i+1]
    sum += val.to_i
  end
end
puts sum
