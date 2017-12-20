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

n.each_with_index do |a,i|
  if i % 3 == 0
    for j in 0..2
      s1 = n[i][j] + n[i+1][j]
      s2 = n[i+1][j] + n[i+2][j]
      s3 = n[i+2][j] + n[i][j]
      if s1 > n[i+2][j] && s2 > n[i][j] && s3 > n[i+1][j]
        sum+=1
      end
    end
  end
end
puts "Sum: #{sum}"

