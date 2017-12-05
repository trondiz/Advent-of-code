#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l.split(" ")
    i += 1
  end
end

n.each do |a|
  h = Array.new
  a.each do |b|
    h << b.chars.sort.join
  end
  w = h.detect{ |e| h.count(e) > 1 }
  if w
    puts "Dupe #{w} => #{h}"
  else
    puts "Uniq #{w} => #{h}"
    sum +=1
  end
end
puts "Sum: #{sum}"

