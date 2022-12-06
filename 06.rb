input = ARGF.each_line.map do |line|
    line.rstrip
end

def find_start(str, num)
    _, pos = str.chars.each_cons(num).with_index.find{|cons, i|
        cons.uniq.count == num
    }

    pos+num
end

p find_start(input.first, 4)
p find_start(input.first, 14)
