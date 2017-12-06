#!/usr/bin/ruby

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    m=l.split(" ")
    m.each_with_index do |v,i|
      n[i]=v.to_i
    end
    i += 1
  end
end
reg=false
history=Array.new
rec=1
str = false
while not str do
  n.each_with_index do |a,i|
    if a == n.max
      o=a
      n[i]=0
      for h in 1..o
        g = (i+h)%(n.length)
        n[g]+=1
      end
  		if history.include? n.join
				puts "Found it #{rec}"
				print n
				str = n.join
				break
		  end
      history[rec]=n.join
      rec+=1
      break
    end
  end
end
puts "PART2"
rec=0
history=[]
while true do         
  n.each_with_index do |a,i|                 
    if a == n.max     
      o=a             
      n[i]=0          
      for h in 1..o   
        g = (i+h)%(n.length)                 
        n[g]+=1       
      end             
      if history.include? str
        puts "Found it #{rec}"
        print n
				exit
      end             
      history[rec]=n.join
      rec+=1
      break
    end
  end
end


