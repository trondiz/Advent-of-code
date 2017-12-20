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


kp = [[0,0,'1',0,0], [0,'2','3','4',0], ['5','6','7','8','9'], [0,'A','B','C',0], [0,0,'D',0,0]]
code = []
x=0
y=2
n.each do |a|
  l = a.split(//)
  l.each do |o|
    puts "#{kp[y][x]} #{o} #{x} #{y}"
    case o
    when 'D'
      y+=1 if y+1 <= 4 && kp[y+1][x] != 0
    when 'L'
      x-=1 if x-1 >= 0 && kp[y][x-1] != 0
    when 'R'
      x+=1 if x+1 <= 4 && kp[y][x+1] != 0
    when 'U'
      y-=1 if y-1 >= 0 && kp[y-1][x] != 0
    end
  end
  code << kp[y][x]
end
puts "Code: #{code.join}"

