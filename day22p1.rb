#!/usr/bin/ruby -w

# Deep clone objects
def dp(w)
  return Marshal.load(Marshal.dump(w))
end


n = Array.new(1000) {Array.new(1000){'.'}}
i = 500
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    # not that readable
    h = l.strip
    h.split(//).each_with_index do |f,j|
      n[i][500+j] = f
    end
    i += 1
  end
end

x = 512
y = 512
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

c = 0
for i in 0..9999
  case n[y][x]
  when '.'
    dir = rotate_left(dir)
    n[y][x] = '#'
		c+=1
  when '#'
    dir = rotate_right(dir)
    n[y][x] = '.'
  end
	case dir
	when 'up'; y-=1
	when 'down'; y+=1
	when 'right'; x+=1
	when 'left'; x-=1
	end
end
#n.each do |v|
#  puts "#{v}"
#end
puts c
