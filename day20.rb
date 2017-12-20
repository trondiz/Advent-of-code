#!/usr/bin/ruby -w

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    g = l.strip.gsub(/</, '')
    k = g.split(/>/)
    n[i] = Hash.new
    k.each do |v|
      b=v.split(/=/)
      o = b[0].split(//).last
      n[i][o] = Array.new
      b[1].split(/,/).each do |m|
        n[i][o] << m.to_i
      end
    end
    i += 1
  end
end
while true 
  n.each_with_index do |a,i|
    n[i]['v'][0] += n[i]['a'][0]
    n[i]['v'][1] += n[i]['a'][1]
    n[i]['v'][2] += n[i]['a'][2]
    n[i]['p'][0] += n[i]['v'][0]
    n[i]['p'][1] += n[i]['v'][1]
    n[i]['p'][2] += n[i]['v'][2]
  end

  d_arr = Array.new
  n.each_with_index do |a,i|
    n.each_with_index do |b, j|
      next if j == i
      if n[i]['p'] == n[j]['p']
        d_arr << n[i]
      end
    end
  end
  d_arr.each do |d|
    n.delete(d)
  end
  puts "num particles: #{n.length}"
end

