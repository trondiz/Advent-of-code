#!/usr/bin/ruby

$n = Hash.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    v = l.split(/ /)
    $n[v[0]] = Hash.new
    $n[v[0]]['con_to'] = Array.new
    for i in 2..v.length-1 do
       $n[v[0]]['con_to'] << v[i].gsub(/[\n,]/ ,"")
    end
  end
end

$prog_id = "0"
$pid_con_to = Array.new

def resolve_my_network(pid)
  k=0
  if ! $pid_con_to.include? pid
    $pid_con_to << pid
  else
    return
  end
  $n[pid.to_s]['con_to'].each do |v|
    resolve_my_network(v)
  end
end

# Part 1
resolve_my_network($prog_id)
puts "Part 1: #{$pid_con_to.uniq.length}"

# Part 2
$groups=1 # We have already resolved one group
$n.each do |k,v|
  if $pid_con_to.include? k
    # already seen, next!
    next
  end
  $groups +=1
  resolve_my_network(k)
end
puts "Part 2: #{$groups}"
