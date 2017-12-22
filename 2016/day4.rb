#!/usr/bin/ruby -w

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    #l.scan(/\d+/)
    t = l.split(/\-\d+/).map!{|b|b.strip}
    c = 99
    real = true
    d = t[1].split(//)
    d.each_with_index do |b,j|
      next if b == '[' || b == ']'
      if t[0].count(b) <= c && t[0].count(b) != 0
        if t[0].count(b) == c && b < d[j-1]
          real = false
          break
        end
        c = t[0].count(b)
      else
        real = false
        break
      end
    end
    if real
      id = l.scan(/\d+/)[0].to_i
      sum += id
      room = l.split(/\[/)[0]
      rarr = room.split(//)
      rarr.each_with_index do |d,k|
        next if d.ord.to_i >= 48 and d.ord.to_i <= 57
        if d == '-'
          rarr[k] = ' '
          next
        end
        chr =  (d.ord.to_i+(id%26))
        if chr > 122
          chr -=26
        end
        rarr[k] = chr.chr
      end
      puts "Part 2: #{rarr.join}" if rarr.join.match(/north/)
      #122
    end
    real = true
    n[i] = l
    i += 1
  end
end

n.each do |a|
end
puts "Part 1: #{sum}"

