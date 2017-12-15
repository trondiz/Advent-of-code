#!/usr/bin/ruby -w

def gena(num)
  a=num*16807
  n = (a % 2147483647)
end

def genb(num)
  a = num*48271
  n = (a % 2147483647)
end


def genap2(num)
  a=num*16807
  n = (a % 2147483647)
  if n % 4 == 0
    return n
  else
    return genap2(n)
  end
end

def genbp2(num)
  a = num*48271
  n = (a % 2147483647)
  if n % 8 == 0
    return n
  else
    return genbp2(n)
  end    
end

a=699
b=124
sum=0
# P1
for i in 0..40000000
  a= gena(a)
  b= genb(b)
  sum +=1 if (a&65535)==(b&65535)
end

puts "Part 1: #{sum}"

sum=0
# P2
for i in 0..5000000
  a= genap2(a)
  b= genbp2(b)
	sum +=1 if (a&65535)==(b&65535)
end

puts "Part2: #{sum}"

