require 'set'

input = ARGF.each_line.map do |line|
    m = line.rstrip.match(/^(\w) (\d+)$/)
    [m[1], m[2].to_i]
end

Knot = Struct.new(:x, :y)

def catch_up(knot_next, knot_prev, dir)
    if (knot_next[dir] - knot_prev[dir]).abs == 2
        knot_next[dir] = (knot_next[dir] + knot_prev[dir])/2
    else
        knot_next[dir] = knot_prev[dir]
    end
end

def solve(length, input)
    knot = []
    length.times do
        knot << Knot.new(0, 0)
    end

    travelled = Set.new

    input.each do |dir, count|
        count.times do |t|
            # puts "#{dir}, #{t}"
            head = knot.first
            case dir
            when 'R'
                head.x += 1
            when 'L'
                head.x -= 1
            when 'U'
                head.y -= 1
            when 'D'
                head.y += 1
            end
            knot.each_cons(2) do |knot_prev, knot_next|
                if (knot_prev.x - knot_next.x).abs > 1
                    catch_up(knot_next, knot_prev, :x)
                    catch_up(knot_next, knot_prev, :y)
                end
                if (knot_prev.y - knot_next.y).abs > 1
                    catch_up(knot_next, knot_prev, :y)
                    catch_up(knot_next, knot_prev, :x)
                end
            end
            travelled << [knot.last.x, knot.last.y]
        end
    end
    travelled.count
end

p solve(2, input)
p solve(10, input)