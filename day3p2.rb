#!/usr/bin/ruby

n = Array.new
i = 0
$input = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    $input = l.to_i
  end
end

x=2500
y=2500

# Init array, nil
$spiral = Array.new(x){Array.new(y)}

# Start in the middle somewhere
x=1250
y=1250

# Set first square
$spiral[x][y] = 1

# Begin calculating from second square
square = 3

# Look around and return sum of adjacent squares
def return_sum(x,y)
  rsum = 0
  #look left
  if $spiral[x-1][y]
     rsum += $spiral[x-1][y]
  end
  #look leftup
  if $spiral[x-1][y+1]
     rsum += $spiral[x-1][y+1]
  end
  #look leftdown
  if $spiral[x-1][y-1]
     rsum += $spiral[x-1][y-1]
  end
  #look up
  if $spiral[x][y+1]
     rsum += $spiral[x][y+1]
  end
  #look right
  if $spiral[x+1][y]
     rsum += $spiral[x+1][y]
  end
  #look rightup
  if $spiral[x+1][y+1]
     rsum += $spiral[x+1][y+1]
  end
  #look rightdown
  if $spiral[x+1][y-1]
     rsum += $spiral[x+1][y-1]
  end
  #look down
  if $spiral[x][y-1]
     rsum += $spiral[x][y-1]
  end
  
  if rsum > $input
    puts "Total sum: #{rsum}"
    # Ugly exit, we have found it!
		exit
	end
  return rsum
end

# Navigation
while true do
  #First round: right, up, left, left, down, down, right
  # right
  x+=1
  $spiral[x][y] = return_sum(x,y)
  # up
  for i in 1..(square-2)
    y+=1
    $spiral[x][y] = return_sum(x,y)
  end
  # left, left
   for i in 1..(square-1)
    x-=1
    $spiral[x][y] = return_sum(x,y)
  end
	# down, down
  for i in 1..(square-1)
    y-=1
    $spiral[x][y] = return_sum(x,y)
  end
  # right, right
  for i in 1..(square-1)
    x+=1
    $spiral[x][y] = return_sum(x,y)
  end
	square+=2
end
