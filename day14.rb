#!/usr/bin/ruby

n = Array.new
seed =""
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    l.split(//).each_with_index do |v,b|
      next if v.ord == 10
      seed += v
    end
  end
end
seed+='-'
$disk=Array.new()
for o in 0..127 do
  y=seed+o.to_s
  n=Array.new
  y.split(//).each_with_index do |v,b|
    n << v.ord
  end
  n << 17 << 31 << 73 << 47 << 23
  list = Array.new
  curr_pos = 0
  skip_size = 0
  # Init list
  for i in 0..255 do
    list[i] = i
  end

  for i in 0..63 do
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
  end

  # List == sparse hash

  dense_hash=Array.new(0)
  for i in 0..15 do
    dense_hash[i]=0
  end
  ll = list.each_slice(16).to_a
  ll.each_with_index do |v,i|
    v.each do |w|
      dense_hash[i] = dense_hash[i] ^ w
    end
  end

  b = Array.new
  dense_hash.each_with_index do |v, i|
    #puts v.to_s(16).rjust(2, '0')
    a= v.to_s(16).rjust(2, '0')
    c =a.split(//)
    c.each do |v|
      b << v.hex.to_s(2).rjust(4, '0')
    end
  end
  $disk[o] = b.map {|s| "#{s}"}.join('').split(//)
end
counter = 0
$disk.each do |v|
  v.each do |b|
    counter +=1 if b == '1'
  end
end
puts "Part1: #{counter}"

$adj = Array.new
def record_adj(y,x)
  #puts "#{y},#{x}"
  return if x < 0 || y < 0
	if $adj.include? "#{y},#{x}"
		return
	end
  if $disk[y] && $disk[y][x] && $disk[y][x] == '1'
    #puts "#{y},#{x} recording"
    $adj << "#{y},#{x}"
		record_adj(y,x+1)
  	record_adj(y,x-1)
		record_adj(y+1,x)
		record_adj(y-1,x)
	end
end
regions = 0

$disk.each_with_index do |y,yi|
#  puts y.length
  y.each_with_index do |x,xi|
    if $adj.include? "#{yi},#{xi}"
      #puts "#{yi},#{xi} already seen"
    else
      if $disk[yi] && $disk[yi][xi] && $disk[yi][xi] == '1'
				record_adj(yi,xi)
				regions +=1
			end
		end
  end
end
puts "Part2: #{regions}"
