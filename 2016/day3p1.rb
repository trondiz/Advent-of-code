#!/usr/bin/ruby -w

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    l = l.strip
    n[i] = l.split(/\s+/).map! {|v| v.to_i}
    i += 1
  end
end

n.each do |a|
  s1 = a[0] + a[1]
  s2 = a[1] + a[2]
  s3 = a[2] + a[0]
  if s1 > a[2] && s2 > a[0] && s3 > a[1]
    sum+=1
  end

end
puts "Sum: #{sum}"

