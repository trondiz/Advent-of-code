#!/usr/bin/ruby

require_relative "lib/knothash"

seed =""
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    seed = l.strip
  end
end
seed+='-'
$disk=Array.new()
for o in 0..127 do
  y=seed+o.to_s
  #puts "#{y}: "
  $disk[o] = Knothash.bin(y).split(//) {|i|i.to_i}
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
  # Negative indices fetches end of array, stupid ruby
	return if x < 0 || y < 0

	# Avoid recursive loops
	return if $adj.include? "#{y},#{x}"

  if $disk[y] && $disk[y][x] && $disk[y][x] == '1'
		# Part of group, record it
    $adj << "#{y},#{x}"
		# Scan neighbours recursively
		record_adj(y,x+1)
  	record_adj(y,x-1)
		record_adj(y+1,x)
		record_adj(y-1,x)
	end
end

# Counter
regions = 0

$disk.each_with_index do |y,yi|
  y.each_with_index do |x,xi|
    if ! $adj.include? "#{yi},#{xi}"
      if $disk[yi] && $disk[yi][xi] && $disk[yi][xi] == '1'
				# Start scan
				record_adj(yi,xi)
				regions +=1
			end
		end
  end
end
puts "Part2: #{regions}"
