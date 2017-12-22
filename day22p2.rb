#!/usr/bin/ruby -w

size = 1000
half = 500
offset = 12

n = Array.new(size) {Array.new(size){'.'}}
i = half
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    # not that readable
    h = l.strip
    h.split(//).each_with_index do |f,j|
      n[i][half+j] = f
    end
    i += 1
  end
end

x = half+offset
y = half+offset
dir = 'up'

def rotate_left(in_dir)
  case in_dir
  when 'up'; return 'left'
  when 'left'; return 'down'
  when 'right'; return 'up'
  when 'down'; return 'right'
  end
end

def rotate_right(in_dir)
  case in_dir
  when 'up'; return 'right'
  when 'left'; return 'up'
  when 'right'; return 'down'
  when 'down'; return 'left'
  end
end

def reverse(in_dir)
  case in_dir
  when 'up'; return 'down'
  when 'down'; return 'up'
  when 'right'; return 'left'
  when 'left'; return 'right'
  end
end

c = 0
for i in 0..9999999
  case n[y][x]
  when '.'
    dir = rotate_left(dir)
    n[y][x] = 'w'
  when '#'
    dir = rotate_right(dir)
    n[y][x] = 'f'
  when 'w'
    dir = dir
    n[y][x] = '#'
    c+=1
  when 'f'
    dir = reverse(dir)
    n[y][x] = '.'
  end
	case dir
	when 'up'; y-=1
	when 'down'; y+=1
	when 'right'; x+=1
	when 'left'; x-=1
	end
end
puts c
