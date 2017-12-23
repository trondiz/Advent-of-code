h = 0
g = 0
e = 0
b = 67
c = b
b = b * 100
b = b + 100000
c = b + 17000
while true
  f = 1
  d = 2
  while g != 0
    e = 2
    if b % d == 0
      f = 0
      break
    end
    d = d + 1
    g = d
    g = g - b
  end
  g = d
  if f == 0
    h += 1
  end
  g = b
  g = g - c
  if g == 0
    puts "Debug: g:#{g} e:#{e} b:#{b} d:#{d} f:#{f} h:#{h}"
    exit
  end
  b = b + 17
end
