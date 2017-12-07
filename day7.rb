#!/usr/bin/ruby

$n = Hash.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    v = l.split(/ /)
    $n[v[0]] = Hash.new
    $n[v[0]]['weight'] = v[1].gsub(/[\(\)]/ ,"")
    $n[v[0]]['lifting'] = Array.new
    $n[v[0]]['carried_by'] = false
    for i in 3..v.length-1 do
       $n[v[0]]['lifting'] << v[i].gsub(/[\n,]/ ,"")
    end
  end
end

# Add carried_by
$n.each do |k,v|
  v['lifting'].each do |l|
    $n[l]['carried_by'] = k
  end
end

$n.each do |k,v|
  puts k if v['carried_by'] == false
end

# PART 2

def get_the_sum_of_my_sub_towers(tower_key)
  weight = 0
  kids = Array.new
  $n[tower_key]['lifting'].each do |v|
    w = get_the_sum_of_my_sub_towers(v)
    kids << w
    weight+=w
    #weight+= $n[tower_key]['weight'].to_i
  end
  if kids.uniq.length > 1
    print kids
    puts "#{tower_key} is not balanced"
  end
  weight += $n[tower_key]['weight'].to_i
  return weight
end

$n['vmttcwe']['lifting'].each do |v|
  f= $n[v]['weight'].to_i
  r=get_the_sum_of_my_sub_towers(v)
  puts "Key: #{v} Weigth: #{r}"
end
