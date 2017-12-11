#!/usr/bin/ruby
n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n = l.split(/,/)
    i += 1
  end
end
n[8222] = n[8222].split(//)[0]
x=0
y=0
z=0
max=0
n.each do |a|
  case a
  when 'n'
    y +=1
    z -=1
  when 's'
    y -=1
    z +=1
  when 'ne'
    x +=1
    z -=1
  when 'sw'
    x -=1
    z +=1
  when 'nw'
    x -=1
    y +=1
  when 'se'
    x +=1
    y -=1
  end
  cur_len = (z.abs+x.abs+y.abs)/2
  max = cur_len if max < cur_len
end
puts (z.abs+x.abs+y.abs)/2
puts max
puts "Sum: #{sum}"

