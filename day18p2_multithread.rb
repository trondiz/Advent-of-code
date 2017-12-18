#!/usr/bin/ruby -w

require 'date'

start = DateTime.now.strftime('%Q').to_i

# Init instructions
$n = Array.new
i = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    $n[i] = Array.new
    l = l.strip
    $n[i] = l.split(/ /)
    i += 1
  end
end

def read_val(pos, u, reg)
  if $n[pos][u].match(/\d/)
    return $n[pos][u].to_i
  else
    return reg[$n[pos][u]]
  end
end

# Shared stuff, putting in global for ease of access
$queue = []
$queue[0] = Array.new
$queue[1] = Array.new
$counter = 0

def run_prog(cur_prog)
  i_pos = 0
  register = Hash.new
  register['p'] = cur_prog
  cur_prog == 1 ? other_prog = 0 : other_prog = 1
  while true
    # Init all seen registers with 0
    if ! register[$n[i_pos][1]]
      register[$n[i_pos][1]] = 0
    end
    case $n[i_pos][0]
    when 'snd'
      $queue[other_prog] << read_val(i_pos, 1, register)
      $counter +=1 if cur_prog == 1
    when 'set'
      register[$n[i_pos][1]] = read_val(i_pos, 2, register)
    when 'add'
        register[$n[i_pos][1]] += read_val(i_pos, 2, register)
    when 'mul'
        register[$n[i_pos][1]] *= read_val(i_pos, 2, register)
    when 'mod'
        register[$n[i_pos][1]] %= read_val(i_pos, 2, register)
    when 'rcv'
      while $queue[cur_prog].length == 0
        # Sleep 0 to allow other thread to run while we wait.
        # There is a race condition here!!!
        sleep 0.00001
        if $queue[other_prog].length == 0 && $queue[cur_prog].length == 0
          return
        end
      end
      register[$n[i_pos][1]]  = $queue[cur_prog].shift.to_i
    when 'jgz'
      if read_val(i_pos, 1, register) > 0
        i_pos += read_val(i_pos, 2, register)
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
puts "Time(ms): #{DateTime.now.strftime('%Q').to_i - start}"
