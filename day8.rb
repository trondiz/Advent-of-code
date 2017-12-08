#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l
    i += 1
  end
end

# init at 0
$regs = Hash.new
n.each do |a|
  ins = a.split(/ /)
$regs[ins[0]] =0
end
$max = 0
# Do math
n.each do |b|
  ins = b.split(/ /)
	#puts "#{ins[3]} #{ins[4]} #{ins[5]} #{ins[6]}"
  case ins[1]
  when 'inc'
    # check condition
    if eval("#{$regs[ins[4]]} #{ins[5]} #{ins[6]}")
      $regs[ins[0]] += ins[2].to_i
    end
  when 'dec'
    if eval("#{$regs[ins[4]]} #{ins[5]} #{ins[6]}")
      $regs[ins[0]] -= ins[2].to_i
    end
	end
  if $regs.values.max > $max
	  $max = $regs.values.max
	end
end
puts "Part 1: #{$regs.values.max}"
puts "Part 2: #{$max}"
