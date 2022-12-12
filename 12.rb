require 'set'

input = ARGF.each_line.map do |line|
    line.rstrip.chars
end

start = nil
stop = nil

input.each_with_index do |line, y|
    line.each_with_index do |c, x|
        case c
        when 'S'
            start = [x, y]
        when 'E'
            stop = [x, y]
        end
    end
end

input[start[1]][start[0]] = 'a'
input[stop[1]][stop[0]] = 'z'

X = input.first.count
Y = input.count

def around(point)
    x, y = point
    [[x-1, y], [x+1, y], [x, y-1], [x, y+1]]
end

def valid_next(input, prev, point, dir, alredy_passed)
    x, y = point
    return false if x < 0
    return false if y < 0
    return false if x >= X
    return false if y >= Y
    return false if alredy_passed.include?(point)

    c1 = input[prev[1]][prev[0]]
    c2 = input[y][x]

    if dir == :down
        return true if c1.ord - c2.ord <= 1
    else
        return true if c2.ord - c1.ord <= 1
    end

    false
end

def solve_until(input:, start:, dir:)
    alredy_passed = Set.new
    steps = [Set.new([start])]
    1000.times do
        next_steps = Set.new
        steps.last.each do |prev|
            next_steps += Set.new(around(prev).select{ |point|
                valid_next(input, prev, point, dir, alredy_passed)
            })
        end
        steps << next_steps
        alredy_passed += Set.new(next_steps)
        break if yield(next_steps)
    end
    steps.count-1
end

p solve_until(input: input, start: start, dir: :up) { |next_steps|
    next_steps.include?(stop)
}
p solve_until(input: input, start: stop, dir: :down) { |next_steps|
    next_steps.any?{|x, y| input[y][x] == 'a'}
}