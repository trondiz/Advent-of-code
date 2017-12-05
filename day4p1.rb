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
  w = a.detect{ |e| a.count(e) > 1 }
  if w
    puts "Dupe #{w} => #{a}"
  else
    puts "Uniq #{w} => #{a}"
    sum +=1
  end
end
puts "Sum: #{sum}"

