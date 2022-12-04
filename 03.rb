lines = ARGF.each_line.map do |line|
    line.strip.chars
end

compartments = lines.map do |line|
    len = line.length

    [line[0...len/2], line[len/2..]]
end

def val(c)
    c == c.upcase ? c.ord - 'A'.ord + 27 : c.ord - 'a'.ord + 1
end

p compartments.inject(0) { |sum, (left, right)|
    c = (left & right).first
    sum += val(c)
}

p lines.each_slice(3).inject(0) { |sum, elfs|
    c = elfs.inject(&:&).first
    sum += val(c)
}
