#!/usr/bin/ruby

def devisible?(a,b)
 if a==b
   return false
 end
 if a > b
   a % b == 0
 else
   b % a == 0
 end
end
n = Array.new
i = 0
sum = 0
File.open("day2/p2in", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l.split(" ")
    i += 1
  end
end

n.each do |a|
  a.each do |b|
    a.each do |c|
      if devisible?(b.to_i, c.to_i)
#        puts "#{b.to_i} is divisible with #{c.to_i}"
        if b.to_i > c.to_i
          puts "d: #{b.to_i/c.to_i}"
          sum += b.to_i/c.to_i
        else
#          puts "d: #{c.to_i/b.to_i}"
#          sum += c.to_i/b.to_i
        end
      end
    end
  end
end
puts "sum: #{sum}"
