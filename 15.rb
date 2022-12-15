class Range
    def overlaps?(other)
        cover?(other.first) || other.cover?(first)
    end
end

closest = {}

input = ARGF.each_line.map do |line|
    xs, ys, xb, yb = line.scan(/-?\d+/).map(&:to_i)
    closest[[xs, ys]] = [xb, yb]
end

# p closest
# yt = 2000000
yt = 11

def dist(x1, y1, x2, y2)
    (x2 - x1).abs + (y2 - y1).abs
end

def dist1(x1, x2)
    (x2 - x1).abs
end

def get_ranges(closest, yt)
    ranges = []

    closest.each do |(xs, ys), (xb, yb)|
        d = dist(xs, ys, xb, yb)
        dy = dist1(yt, ys)
        next if dy > d

        diff = d - dy

        ranges << (xs - diff...xs + diff)
    end
    ranges
end
# p ranges

def look_hole(ranges)
    # p ranges.sort_by{|r| r.begin}

    ranges.sort_by{|r| r.begin}.inject do |big, r|
        if big.last + 1 < r.first
            return big.last + 1
        end

        (big.first...[big.last, r.last].max)
    end
    false
end

(0..4000000).each do |y|
    ranges = get_ranges(closest, y)
    x = look_hole(ranges)
    puts "#{x} #{y}" if x
end

