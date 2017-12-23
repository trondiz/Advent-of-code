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
$counter = 0

def run_prog(cur_prog)
  i_pos = 0
  register = {
    'a' => 1,
    'b' => 0,
    'c' => 0,
    'd' => 0,
    'e' => 0,
    'f' => 0,
    'g' => 0,
    'h' => 0,
  }
  $n.each_with_index do |k,i|
    system('clear')
    if i == i_pos
      puts "#{k} <-"
    end
    puts k
  end
  while $n[i_pos]
	sleep 0.1
	system('clear')
  $n.each_with_index do |k,i|                            
    if i == i_pos
      puts "#{k} <- #{register}" 
    end
    puts "#{k}"
  end
#    puts "#{$n[i_pos]}"
#    puts "#{register}"
#    sleep 0.5
    case $n[i_pos][0]
    when 'set'
      register[$n[i_pos][1]] = read_val(i_pos, 2, register)
    when 'sub'
        register[$n[i_pos][1]] -= read_val(i_pos, 2, register)
    when 'mul'
        register[$n[i_pos][1]] *= read_val(i_pos, 2, register)
        $counter +=1
    when 'jnz'
      if read_val(i_pos, 1, register) != 0
        i_pos += read_val(i_pos, 2, register)
        next
      end
    end
    i_pos += 1
  end
end

run_prog(0)
puts "Mul: #{$counter}"
