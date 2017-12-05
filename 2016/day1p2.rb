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

$map=Array.new(800){Array.new(800)}

$a=x=o=400
$b=y=p=400

#n, e, s, w
direction="n"
def mark_n_check(x,y)
	if $map[x][y]
    puts "Twice!"
    res = 0
    x>$a ? res=x-$a : res=$a-x
    y>$b ? res+=y-$b : res+=$b-y
    puts "Distance: #{res}"
	else
	#	puts "#{x} #{y}"
		$map[x][y]=true
	end
end

n.each do |d|
  m = d.split(//)
	s = d.scan(/\d+/).first.to_i
  case m[0]
  when "L"
    case direction
    when "n"
      direction = "w"
      for i in 1..s
        mark_n_check(x,y)
				x-=1
			end
    when "e"
      direction = "n"
      for i in 1..s
        mark_n_check(x,y)
				y+=1
			end
    when "s"
      direction = "e"
      for i in 1..s
        mark_n_check(x,y)
				x+=1
			end
    when "w"
      direction = "s"
      for i in 1..s
        mark_n_check(x,y)
				y-=1
			end
    end
  when "R"
    case direction
    when "n"
      direction = "e"
      for i in 1..s
        mark_n_check(x,y)
				x+=1
			end
    when "e"
      direction = "s"
      for i in 1..s
        mark_n_check(x,y)
				y-=1
			end
    when "s"
      direction = "w"
      for i in 1..s
        mark_n_check(x,y)
				x-=1
			end
    when "w"
      direction = "n"
      for i in 1..s
        mark_n_check(x,y)
			  y+=1
      end
    end
	end
end
