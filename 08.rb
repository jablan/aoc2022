input = ARGF.each_line.map do |line|
    line.rstrip.chars.map{|c| c.to_i}
end

X = input.first.count
Y = input.count

visible = {}
scenic = {}
0.upto(Y-1) do |y|
    max = -1
    last_seen = Hash.new(0)
    0.upto(X-1) do |x|
        h = input[x][y]
        if h > max
            visible[[x, y]] = true
            max = h
        end
        scenic[[x, y]] ||= {}
        scenic[[x, y]][0] = x - last_seen[h]
        (0..h).each{|i| last_seen[i] = x}
    end

    max = -1
    last_seen = Hash.new(X-1)
    (X-1).downto(0) do |x|
        h = input[x][y]
        if h > max
            visible[[x, y]] = true
            max = h
        end
        scenic[[x, y]] ||= {}
        scenic[[x, y]][1] = last_seen[h] - x
        (0..h).each{|i| last_seen[i] = x}
    end
end
0.upto(X-1) do |x|
    max = -1
    last_seen = Hash.new(0)
    0.upto(Y-1) do |y|
        h = input[x][y]
        if h > max
            visible[[x, y]] = true
            max = h
        end
        scenic[[x, y]] ||= {}
        scenic[[x, y]][2] = y - last_seen[h]
        (0..h).each{|i| last_seen[i] = y}
    end
    max = -1
    last_seen = Hash.new(Y-1)
    (Y-1).downto(0) do |y|
        h = input[x][y]
        if h > max
            visible[[x, y]] = true
            max = h
        end
        scenic[[x, y]] ||= {}
        scenic[[x, y]][3] = last_seen[h] - y
        (0..h).each{|i| last_seen[i] = y}
    end
end

p visible.count
# p scenic
p scenic.map{|_k, v|
    v.values.inject(1, &:*)
}.max