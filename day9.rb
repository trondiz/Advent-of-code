#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    l.split(//).each do |k|
      n[i] = k
      i += 1
    end
  end
end

rsum = 0
depth = 0
garbage = false
sum = 0
skipnext = false

n.each_with_index do |a,i|
  if skipnext
    skipnext = false
    next
  end
  if garbage
    case a
    when ">"
      garbage = false
    when "!"
      skipnext = true
    else
      rsum += 1
    end
  else
    case a
    when "{"
      depth +=1
      sum += depth
    when "}"
      depth -= 1
    when "<"
      garbage = true
    end
  end
end
puts "Sum: #{sum}"
puts "Rsum #{rsum}"
