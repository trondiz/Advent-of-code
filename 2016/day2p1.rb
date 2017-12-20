#!/usr/bin/ruby -w

n = Array.new
i = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l.strip
    i += 1
  end
end

kp = [[1,2,3],[4,5,6],[7,8,9]]

min = 0
max = 2
code = []
x=1
y=1
n.each do |a|
  l = a.split(//)
  l.each do |o|
    case o
    when 'D'
      y+=1 if y != max;
    when 'L'
      x-=1 if x != min;
    when 'R'
      x+=1 if x != max;
    when 'U'
      y-=1 if y != min;
    end
  end
  code << kp[y][x]
end
puts "Code: #{code.join}"

