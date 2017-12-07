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
$p1 = ''
$n.each do |k,v|
  if v['carried_by'] == false
    puts "Part 1: #{k}"
    $p1 = k
  end
end

# PART 2
$cnd  = Array.new

def get_the_sum_of_my_sub_towers(tower_key)
  weight = 0
  kids = Hash.new
  $n[tower_key]['lifting'].each do |v|
    w = get_the_sum_of_my_sub_towers(v)
    kids[v] = w
    weight+=w
  end

  if kids.values.uniq.length > 1
    ww = kids.values.select{|e| kids.values.count(e) ==1 }
    ada = kids.values.select{|e| kids.values.count(e) >1 }
    wwk = kids.select{|k,v| v == ww[0]}
    adak = kids.select{|k,v| v == ada[0]}
    diff = wwk.values[0] - adak.values[0]
    res = $n[wwk.keys[0]]['weight'].to_i - diff
    puts "Part 2: #{res}"
    # We have found the answer, no point in searching further
    exit
  end
  weight += $n[tower_key]['weight'].to_i
  return weight
end

get_the_sum_of_my_sub_towers($p1)

