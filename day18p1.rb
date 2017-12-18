#!/usr/bin/ruby -w

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    l = l.strip
    n[i] = l.split(/ /)
    i += 1
  end
end

i_pos = 0
last_sound = 0
register = Hash.new
while true
  if i_pos < 0 || i_pos > n.length
    puts "Jumped off"
    exit
  end
  print n[i_pos]
  # Init all seen registers with 0
  if ! register[n[i_pos][1]]
    register[n[i_pos][1]] = 0
  end
  print register
  puts
  case n[i_pos][0]
  when 'snd'
    last_sound = register[n[i_pos][1]].to_i
  when 'set'
    if n[i_pos][2].match(/\d/)
      register[n[i_pos][1]] = n[i_pos][2].to_i
    else
      register[n[i_pos][1]] = register[n[i_pos][2]].to_i
    end   
  when 'add'
    if n[i_pos][2].match(/\d/)
      register[n[i_pos][1]] +=  n[i_pos][2].to_i
    else
      register[n[i_pos][1]] +=  register[n[i_pos][2]].to_i
    end 
  when 'mul'
    if n[i_pos][2].match(/\d/)
      register[n[i_pos][1]] *= n[i_pos][2].to_i
    else
      register[n[i_pos][1]] *= register[n[i_pos][2]].to_i
    end
  when 'mod'
    if n[i_pos][2].match(/\d/)
      register[n[i_pos][1]] %= n[i_pos][2].to_i
    else
      register[n[i_pos][1]] %= register[n[i_pos][2]].to_i
    end
  when 'rcv'
    if register[n[i_pos][1]] == 0
      i_pos +=1
      next
    end
    puts "recovered, freq of last_sound #{last_sound}"
    exit
  when 'jgz'
    if register[n[i_pos][1]] > 0
      puts "I am at #{i_pos}"
      if n[i_pos][2].match(/\d/)
        i_pos += n[i_pos][2].to_i
      else
        i_pos += register[n[i_pos][2]]
      end
      puts "Going to #{i_pos}"
      next
    end
  end
  i_pos += 1
end
puts "Sum: #{sum}"

