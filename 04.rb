elfs = ARGF.each_line.map do |line|
    line
    .strip
    .split(',')
    .map!{ |r|
        Range.new(*(r.split('-').map(&:to_i)))
    }
end

class Range
    def overlaps?(other)
        cover?(other.first) || other.cover?(first)
    end
end

p elfs.count{|left, right|
    left.cover?(right) || right.cover?(left)
}

p elfs.count{|left, right|
    left.overlaps?(right)
}
