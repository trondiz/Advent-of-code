#!/usr/bin/ruby

n = Hash.new
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    k= l.split(/: /)
    n[k[0]] = k[1].gsub(/\n/,'').to_i
  end
end

$max = n.keys.last.to_i
$cstate = Hash.new
$cdir = Hash.new

def move_scanners(state, dir)
  st = Marshal.load Marshal::dump(state)
  d = Marshal.load Marshal::dump(dir)
  st.each do |k,v|
    # Move scanners
    s=st[k].index("S")
    st[k][s]='0'
    # Change direction
    if s == st[k].length-1
      d[k] = 'up'
    end
    if s == 0
      d[k] = 'down'
    end
    case d[k]
    when 'down'
      st[k][s+1] = "S"
    when 'up'
      st[k][s-1] = "S"
    end
  end
  return [st, d]
end

def do_the_walk(state, dir)
  st = Marshal.load Marshal::dump(state)
  d = Marshal.load Marshal::dump(dir)
  pos = 0
	caught = false
  while pos <= $max
    if st[pos.to_s] && st[pos.to_s][0] == "S"
			caught = true
			break
    end
    pos+=1
    bar = move_scanners(st, d)
    st = bar[0]
    d = bar[1]
  end
	return caught
end

n.each do |k,v|
  $cstate[k] = Array.new(v) {'0'}
  $cdir[k] = Array.new(1) {'down'}
  $cstate[k][0] = 'S'
end

puts $cdir
puts $cstate
# Game loop
cc=0

while true
  # set state for next delay
  e=$cstate
  r=$cdir
  puts cc
	if ! do_the_walk($cstate, $cdir)
    puts "Not caught! delay #{cc}"
    exit
  end
  foo = move_scanners($cstate, $cdir)
  $cstate=foo[0]
  $cdir=foo[1]
  cc+=1
end
