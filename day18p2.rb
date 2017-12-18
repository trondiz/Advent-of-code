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

cur_prog = 0
state = Hash.new
state[0] = Hash.new
state[1] = Hash.new
state[0]['register'] = Hash.new
state[1]['register'] = Hash.new
state[0]['queue'] = Array.new
state[1]['queue'] = Array.new
state[0]['i_pos'] = 0
state[1]['i_pos'] = 0
state[0]['register']['p'] = 0
state[1]['register']['p'] = 1
state[cur_prog]['i_pos'] = 0
last_sound = 0
counter = 0
c=0
while true
  if cur_prog == 1
    other_prog = 0
  else
    other_prog = 1
  end
  if state[cur_prog]['i_pos'] < 0 || state[cur_prog]['i_pos'] > n.length
    puts "Jumped off"
    exit
  end
  if ! state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]]
    state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] = 0
  end
  case n[state[cur_prog]['i_pos']][0]
  when 'snd'
    if n[state[cur_prog]['i_pos']][1].match(/\d/)
      state[other_prog]['queue'] << n[state[cur_prog]['i_pos']][1].to_i
    else
      state[other_prog]['queue'] << state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]].to_i    
    end
    if cur_prog == 1
      counter += 1
    end
  when 'set'
    if n[state[cur_prog]['i_pos']][2].match(/\d/)
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] = n[state[cur_prog]['i_pos']][2].to_i
    else
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] = state[cur_prog]['register'][n[state[cur_prog]['i_pos']][2]].to_i
    end   
  when 'add'
    if n[state[cur_prog]['i_pos']][2].match(/\d/)
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] +=  n[state[cur_prog]['i_pos']][2].to_i
    else
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] +=  state[cur_prog]['register'][n[state[cur_prog]['i_pos']][2]].to_i
    end 
  when 'mul'
    if n[state[cur_prog]['i_pos']][2].match(/\d/)
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] *= n[state[cur_prog]['i_pos']][2].to_i
    else
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] *= state[cur_prog]['register'][n[state[cur_prog]['i_pos']][2]].to_i
    end
  when 'mod'
    if n[state[cur_prog]['i_pos']][2].match(/\d/)
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] %= n[state[cur_prog]['i_pos']][2].to_i
    else
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] %= state[cur_prog]['register'][n[state[cur_prog]['i_pos']][2]].to_i
    end
  when 'rcv'
    # check queue, if, empty switch to other_prog
    if state[cur_prog]['queue'].length == 0
      cur_prog = other_prog
      next
    else
      if c % 100000 == 0
        puts "#{state[1]['queue'].length}: #{counter}"
      end
      #puts n[state[cur_prog]['i_pos']+1][0]
#      if n[state[cur_prog]['i_pos']-q][1] == 'b'
#        state[cur_prog]['queue'].clear
#        cur_prog = other_prog
#      end
      state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]]  = state[cur_prog]['queue'].shift.to_i
    end
    

    if state[cur_prog]['queue'].length == 0 && state[other_prog]['queue'].length == 0
      puts "Deadlock: #{counter}"
      exit
    end
  when 'jgz'
    if n[state[cur_prog]['i_pos']][1].match(/\d/)
      if n[state[cur_prog]['i_pos']][2].match(/\d/)
        state[cur_prog]['i_pos'] += n[state[cur_prog]['i_pos']][2].to_i
      else
        state[cur_prog]['i_pos'] += state[cur_prog]['register'][n[state[cur_prog]['i_pos']][2]]
      end
      next
    end
    if state[cur_prog]['register'][n[state[cur_prog]['i_pos']][1]] > 0
      #puts "I am at #{state[cur_prog]['i_pos']}"
      if n[state[cur_prog]['i_pos']][2].match(/\d/)
        state[cur_prog]['i_pos'] += n[state[cur_prog]['i_pos']][2].to_i
      else
        state[cur_prog]['i_pos'] += state[cur_prog]['register'][n[state[cur_prog]['i_pos']][2]]
      end
      #puts "Going to #{state[cur_prog]['i_pos']}"
      next
    end
  end
  state[cur_prog]['i_pos'] += 1
  c+=1
end
puts "Sum: #{sum}"

