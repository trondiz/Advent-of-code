#!/usr/bin/ruby

n = Hash.new
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    k= l.split(/: /)
    n[k[0]] = k[1].gsub(/\n/,'').to_i
  end
end

max = n.keys.last.to_i
pos=0
state = Hash.new
dir = Hash.new
n.each do |k,v|
  state[k] = Array.new(v) {'0'}
  dir[k] = Array.new(v) {'down'}
  state[k][0] = 'S'
end
# Game loop
caught = false
while pos <= max
  # I move
  #print state
  #puts pos
  if state[pos.to_s] && state[pos.to_s][0] == "S"
    caught = true
#    puts "#{pos}*#{state[pos.to_s].length}"
    sum+=pos*state[pos.to_s].length
  end
  pos+=1
  #Scanners move
  state.each do |k,v|
    # Move scanners
    s=state[k].index("S")
    state[k][s]='0'
    # Change direction
    if s == state[k].length-1
      dir[k] = 'up'
    end
    if s == 0
      dir[k] = 'down'
    end
    case dir[k]
    when 'down'
      state[k][s+1] = "S"
    when 'up'
      state[k][s-1] = "S"
    end
  end
end
puts "Sum: #{sum}"

