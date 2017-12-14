#!/usr/bin/ruby -w

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

n.each do |a|

end
puts "Sum: #{sum}"

