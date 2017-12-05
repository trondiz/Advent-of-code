#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n = Array.new
    l.split(/, /).each_with_index do |val, index|
      n[index]=val
    end
  end
end

map=Array.new(2500){Array.new(2500)}

a=x=1250
b=y=1250

#n, e, s, w
direction="n"

n.each do |d|
  m = d.split(//)
	s = d.scan(/\d+/).first.to_i
  case m[0]
  when "L"
    case direction
    when "n"
      direction = "w"
			x-=s
    when "e"
      direction = "n"
			y+=s
    when "s"
      direction = "e"
			x+=s
    when "w"
      direction = "s"
			y-=s
    end
  when "R"
    case direction
    when "n"
      direction = "e"
			x+=s
    when "e"
      direction = "s"
			y-=s
    when "s"
      direction = "w"
			x-=s
    when "w"
      direction = "n"
			y+=s
    end
	end
end
puts "X: #{x} Y: #{y}\nA: #{a} B: #{b}"

res = 0
x>a ? res=x-a : res=a-x
y>b ? res+=y-b : res+=b-y
puts "Distance: #{res}"

