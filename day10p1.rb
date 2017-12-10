#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    l.split(/,/).each_with_index do |v,b|
      n[b] = v.to_i
    end
  end
end

list = Array.new
curr_pos = 0
skip_size = 0
# Init list
for i in 0..255 do
  list[i] = i
end

n.each do |a|
  # create sub array and rev it
  ta = Array.new
  for i in 0..a-1 do
    ta[i] = list[(curr_pos+i)%list.length]
  end
#  print ta
  ra = ta.reverse
  for i in 0..a-1 do
    list[(curr_pos+i)%list.length] = ra[i]
  end
#  print list
  curr_pos += a
  curr_pos += skip_size
  skip_size += 1
end

puts "Finish #{list[0]*list[1]}"
#print list

