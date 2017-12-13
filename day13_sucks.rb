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

def move_scanners(st, d)
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
  pos = 0
  while pos <= $max
    if state[pos.to_s] && state[pos.to_s][0] == "S"
			puts "#{pos} * #{state[pos.to_s].length}"
      return true
    end
    pos+=1
    bar = move_scanners(state, dir)
    state = bar[0]
    dir = bar[1]
  end
	return false
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

puts "STARTING\n\n\n"
while cc < 100
  # Reset state for each delay
  caught = false
  pos= 0
  state = $cstate
  dir  = $cdir
  if ! do_the_walk($cstate, $cdir)
    puts "Not caught! delay #{cc}"
    exit
  end
  puts $cstate
  puts $cdir
  foo = move_scanners($cstate, $cdir)
  $cstate=foo[0]
  puts $cstate
  $cdir=foo[1]
  puts $cdir
  cc+=1
end
