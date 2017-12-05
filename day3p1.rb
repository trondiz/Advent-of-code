#!/usr/bin/ruby

# Find square by using power of 2 ranges
#
input = 361527
found = 0
src = 1
min = 1
max = 1
counter = 0
while found == 0 do
  if input > min && input < max
    found = 1
    break
  end
  min = max
  counter +=1
  src +=2
  max = src**2
end
puts src
puts counter

decounter = src-1
init = counter
# 2, 6, 10, 14
p=0
da = Array.new
until p==4 do
  da[p] = (src**2-init)
  init += decounter
  p+=1
end
ra = Array.new
da.each_with_index do |v,i|
  res = v - input
  if res < 0
    res = -res
  end
  ra[i] = res
end
puts ra.min
puts "Distance: #{ra.min+counter}"
