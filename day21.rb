#!/usr/bin/ruby -w

# Deep clone objects
def dp(w)
  return Marshal.load(Marshal.dump(w))
end

def rotate3! (input)
  a = input[0][0][0]
  b = input[0][0][1]
  c = input[0][0][2]
  d = input[0][1][0]
  e = input[0][1][2]
  f = input[0][2][0]
  g = input[0][2][1]
  h = input[0][2][2]
  input[0][0][0] = f
  input[0][0][1] = d
  input[0][0][2] = a
  input[0][1][0] = g
  input[0][1][2] = b
  input[0][2][0] = h
  input[0][2][1] = e
  input[0][2][2] = c
  return input
end

def rotate2! (input)
  a = input[0][0][0]
  b = input[0][0][1]
  c = input[0][1][0]
  d = input[0][1][1]
  input[0][0][0] = c
  input[0][0][1] = a
  input[0][1][0] = d
  input[0][1][1] = b
  return input
end

n = Array.new
i = 0
sum = 0
File.open("data", "r") do |f|
  f.each_line do |l|
    n[i] = Array.new
    # not that readable
    n[i] = l.split(/=>/).map!{ |b| b.gsub(/ /, '').strip}.map!{|m| m.split(/\//)}.map!{|t| t.map!{|e| e.split(//)}}
    pat = dp(n[i])
    if n[i][0].length == 2
      for rt in 1..3
        i += 1
        n[i] = dp(rotate2!(pat))
      end
      pat[0].reverse!
      for rt in 0..3
        i += 1
        n[i] = dp(rotate2!(pat))
      end
    end
    if n[i][0].length == 3
      for rt in 1..3
        i += 1
        n[i] = dp(rotate3!(pat))
      end
      pat[0].reverse!
      for rt in 0..3
        i += 1
        n[i] = dp(rotate3!(pat))
      end
    end
    i += 1
  end
end

image = [['.','#','.'],['.','.','#'],['#','#','#']]
for int in 0..17
  if image.length % 2 == 0
    # scan 2x2 and blow up using enchantments
    new = []
    i=0
    while i < image.length
      j = 0
      while j < image.length
        # starting points: 0,0 | 0,2 | 2,0 | 2,2
        img = Array.new(2) {[]}
        img[0] << image[i][j]
        img[0] << image[i][j+1]
        img[1] << image[i+1][j]
        img[1] << image[i+1][j+1]
        n.each do |m|
          if m[0] == img # get sub
            #puts "#{m[0]} matches #{img} and that gives #{m[1]}"
            new[0+i*1.5] = Array.new if not new[0+i*1.5]
            new[0+i*1.5] << m[1][0]
            new[1+i*1.5] = Array.new if not new[1+i*1.5]
            new[1+i*1.5] << m[1][1]
            new[2+i*1.5] = Array.new if not new[2+i*1.5]
            new[2+i*1.5] << m[1][2]
            break
          end
        end
        j+=2
      end
      i+=2
    end
    #puts "#{new.map{|b|b.flatten}}"
    image = dp(new.map{|b|b.flatten})
  else 
    # scan 3x3 and apply enchantment
    if int == 0
      i = 0 # +=3
      while i < image.length
        n.each do |m|
          if m[0] == image # get sub
            image = dp(m[1])
          end
          i+=3
        end
      end
    else
      new = []
      i=0
      while i < image.length
        j = 0
        while j < image.length
          # starting points: 0,0 | 0,3 | 3,0 | 3,3
          img = Array.new()
          img[0] = Array.new if not img[0]
          img[0] << image[i][j]
          img[0] << image[i][j+1]
          img[0] << image[i][j+2]
          img[1] = Array.new if not img[1]
          img[1] << image[i+1][j]
          img[1] << image[i+1][j+1]
          img[1] << image[i+1][j+2]
          img[2] = Array.new if not img[2]
          img[2] << image[i+2][j]
          img[2] << image[i+2][j+1]
          img[2] << image[i+2][j+2]
          n.each do |m|
            if m[0] == img # get sub
              #puts "#{m[0]} matches #{img} and that gives #{m[1]}"
              o = (i*1.333333333333).round # offset, beware bugs be here. Add more 3's for more iterations if code break
              new[0+o] = Array.new if not new[0+o]
              new[0+o] << m[1][0]
              new[1+o] = Array.new if not new[1+o]
              new[1+o] << m[1][1]
              new[2+o] = Array.new if not new[2+o]
              new[2+o] << m[1][2]
              new[3+o] = Array.new if not new[3+o]
              new[3+o] << m[1][3]
              break
            end
          end
          j+=3
        end
        i+=3
      end
      #puts "#{new.map{|b|b.flatten}}"
      image = dp(new.map{|b|b.flatten})
    end
  end
  puts "\e[H\e[2J"
  image.each do |h|
    puts h.join
  end
  sleep 1
puts "\e[H\e[2J"
end
s = 0
image.each do |h|
  h.each do |g|
    s +=1 if g == "#"
  end
end

puts s

