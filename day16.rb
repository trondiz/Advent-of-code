#!/usr/bin/ruby


# Get dance moves
$n = Array.new
File.open("data", "r") do |f|
  f.each_line do |l|
    $n=l.split(/,/)
  end
end

# Init dance
prog = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p']

# Do one dance
def dance!(program)
  $n.each do |a|
    type = a[0]
    case type
    when 's'
      program.rotate!(-a.gsub(/s/, '').to_i)
    when 'x'
      tmp = a.split(/\//)
      u = tmp[0].gsub(/x/, '').to_i
      y = tmp[1].to_i
      program[u],program[y] = program[y],program[u]
    when 'p'
      tmp = a.split(//)
      m = program.index(tmp[1])
      n = program.index(tmp[3])
      program[m],program[n] = program[n], program[m]
    end
  end
end

#Part 1
dance!(prog)
puts "Part 1: #{prog.join()}"

# Reset for part 2
prog = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p']

# Dance a billion times! kidding! We only need 40
states = Array.new
for g in 1..40
  if states.include? prog.join()
    d = states.index(prog.join())
    puts d
    prog = states[(d+1)%states.length].split(//)
    next
  else
    states << prog.join
  end
  dance!(prog)
end

puts "Part 2: #{prog.join}"
