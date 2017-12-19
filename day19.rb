#!/usr/bin/ruby -w

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    n[i] = l.split(//)
    i += 1
  end
end

x = 0
y = 0

$text = []

$dir = 'down'

# find starting x
n[0].each_with_index do |v, i|
  x = i if v == '|'
end

def test_next_pos(map, cx, cy)
	if map[cy][cx] == '+'
		if map[cy][cx-1] == '-' && $dir != 'right'
			$dir = 'left' 
		elsif map[cy][cx+1] == '-' && $dir != 'left'
			$dir = 'right'
		elsif map[cy-1][cx] == '|' && $dir != 'down'
			$dir = 'up'
 		elsif map[cy+1][cx] == '|' && $dir != 'up'
			$dir = 'down'
		else
      puts "No valid dir"
		end
	end
  if map[cy][cx] =~ /[A-Z]/
    $text << map[cy][cx]
  end
end

c = 0
while true
	if n[y][x] == 'T'
		print $text
    puts
		puts c
		exit
	end
  puts "#{x}, #{y}, cur_val #{n[y][x]}"
  # No diagonals, look around and find next pos
	case $dir
	when 'down'
  	test_next_pos(n, x, y+1)
    y += 1
  when 'up'
		test_next_pos(n, x, y-1)
    y -= 1
  when 'left'
		test_next_pos(n, x-1, y)
    x -= 1
  when 'right'
		test_next_pos(n, x+1, y)
    x += 1
  end
	c+=1
end
