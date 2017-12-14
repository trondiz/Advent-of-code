class Knothash
  def self.hash(string)
    n = Array.new
    i = 0
    sum = 0
    string.split(//).each_with_index do |v,b|
      # Skip newlines
      next if v.ord == 10
      n[b] = v.ord
    end
    
    # Knothash sparkle
    n << 17 << 31 << 73 << 47 << 23
    list = Array.new
    curr_pos = 0
    skip_size = 0
    # Init list
    for i in 0..255 do
      list[i] = i
    end

    for i in 0..63 do
      n.each do |a|
        # create sub array and rev it
        ta = Array.new
        for i in 0..a-1 do
          ta[i] = list[(curr_pos+i)%list.length]
        end
      #  print ta
        ra = ta.reverse
        for i in 0..a-1 do
          list[(curr_pos+i)%list.length] = ra[i]
        end
      #  print list
        curr_pos += a
        curr_pos += skip_size
        skip_size += 1
      end
    end

    # List == sparse hash

    dense_hash=Array.new(0)
    for i in 0..15 do
      dense_hash[i]=0
    end
    ll = list.each_slice(16).to_a
    ll.each_with_index do |v,i|
      v.each do |w|
        dense_hash[i] = dense_hash[i] ^ w
      end
    end
    return dense_hash
  end

  def self.hex(string)
    num_hash = hash(string)
    b = Array.new
    num_hash.each_with_index do |v, i|
      b << v.to_s(16).rjust(2, '0')
    end
    return b.map {|s| "#{s}"}.join('')
  end

  def self.bin(string)
    num_hash = hash(string)
    b = Array.new
    num_hash.each_with_index do |v, i|
      a= v.to_s(16).rjust(2, '0')
      c= a.split(//)
      c.each do |v|
        b << v.hex.to_s(2).rjust(4, '0')
      end
    end
    return b.map {|s| "#{s}"}.join('')
  end
end
