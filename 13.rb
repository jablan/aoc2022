lines = ARGF.each_line.map do |line|
    eval(line.rstrip)
end

input = lines.slice_when{|line| line.nil?}

def cmp(l, r)
    return 1 if r.nil?
    return -1 if l.nil?
    return l <=> r if l.is_a?(Integer) && r.is_a?(Integer)
    l = [l] if l.is_a?(Integer)
    r = [r] if r.is_a?(Integer)
    cmp_a(l, r)
end

def cmp_a(left, right)
    left += [nil] * (right.count - left.count) if right.count > left.count
    left.zip(right).each{|l, r|
        res = cmp(l, r)
        return res if res != 0
    }
    0
end

vals = input.map { |pair|
    left, right, _rest = pair
    cmp_a(left, right)
}

p vals.each_with_index.inject(0) {|acc, (v, i)|
    acc += i + 1 if v == -1
    acc
}

lines = lines.reject{|line| line.nil?} + [[[2]], [[6]]]
sorted = lines.reject{|line| line.nil?}.sort{|l,r| cmp_a(l, r)}

p (sorted.index([[2]])+1) * (sorted.index([[6]])+1)
