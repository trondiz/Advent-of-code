#!/usr/bin/ruby

n = Array.new()
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    k= l.split(/: /)
    n[k[0].to_i] = k[1].gsub(/\n/,'').to_i
  end
end

pos=0
# Game loop
delay = 0
caught = false
while true
  caught = false
  pos = 0
  while pos <= n.length
    # I mov
    if n[pos] && ((pos+delay) % ((n[pos]-1)*2) ==0)
      puts "((#{pos}+#{delay} % ((#{n[pos]}-1)*2) ==0)"
      puts pos
      caught = true
      break
    end
    pos+=1
  end
  if ! caught
    puts delay
    puts "win"
    exit
  end
  delay +=1
end
