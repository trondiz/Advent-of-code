#!/usr/bin/ruby -w

# Shared stuff, putting in global for ease of access
$queue = []
$waiting = []
$waiting[0] = false
$waiting[1] = false
$queue[0] = Array.new
$queue[1] = Array.new
$counter = 0

# The program function
def run_prog(cur_prog)
  n = Array.new
  i = 0
  File.open("data", "r") do |f|
    f.each_line do |l|
      n[i] = Array.new
      l = l.strip
      n[i] = l.split(/ /)
      i += 1
    end
  end

  i_pos = 0
  register = Hash.new
  register['p'] = cur_prog
  if cur_prog == 1
    other_prog = 0
  else
    other_prog = 1
  end
  while true
    if i_pos < 0 || i_pos > n.length
      puts "Jumped off"
      exit
    end
    # print n[i_pos]
    # Init all seen registers with 0
    if ! register[n[i_pos][1]]
      register[n[i_pos][1]] = 0
    end
    #print register
    #puts
    case n[i_pos][0]
    when 'snd'
      if n[i_pos][1].match(/\d/)
        $queue[other_prog] << n[i_pos][1].to_i
      else
        $queue[other_prog] << register[n[i_pos][1]]
      end
      if cur_prog == 1
        $counter += 1
      end
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
      #
      b = 0
      while $queue[cur_prog].length == 0
        # Sleep 0 to allow other thread to run while we wait. 
        sleep 0
        # I am waiting. Introducing delay before calling it
        # to reduce chance of race condition. TODO: Remove delay
        b +=1
        if b > n.length
          $waiting[cur_prog] = true
          if $waiting[other_prog]
            return
          end
        end
      end
      $waiting[cur_prog] = false
      register[n[i_pos][1]]  = $queue[cur_prog].shift.to_i
    when 'jgz'
      if n[i_pos][1].match(/\d/)
        if n[i_pos][2].match(/\d/)
          i_pos += n[i_pos][2].to_i
        else
          i_pos += register[n[i_pos][2]].to_i
        end
        next
      end
      if register[n[i_pos][1]] > 0
        #puts "I am at #{i_pos}"
        if n[i_pos][2].match(/\d/)
          i_pos += n[i_pos][2].to_i
        else
          i_pos += register[n[i_pos][2]]
        end
        #puts "Going to #{i_pos}"
        next
      end
    end
    i_pos += 1
  end
end

p1 = Thread.new{run_prog(0)}
p2 = Thread.new{run_prog(1)}
p1.join
p2.join
puts "Deadlock 2: #{$counter}"
