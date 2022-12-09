require 'set'

input = ARGF.each_line.map do |line|
    m = line.rstrip.match(/^(\w) (\d+)$/)
    [m[1], m[2].to_i]
end

def solve(length, input)
    knot = []
    length.times do
        knot << [0, 0]
    end

    travelled = Set.new

    input.each do |dir, count|
        count.times do |t|
            # puts "#{dir}, #{t}"
            case dir
            when 'R'
                knot[0][0] += 1
            when 'L'
                knot[0][0] -= 1
            when 'U'
                knot[0][1] -= 1
            when 'D'
                knot[0][1] += 1
            end
            (1..length-1).each do |i|
                if knot[i-1][0] - knot[i][0] > 1
                    knot[i][0] = knot[i][0]+1
                    if (knot[i][1] - knot[i-1][1]).abs == 2
                        knot[i][1] = (knot[i][1] + knot[i-1][1])/2
                    else
                        knot[i][1] = knot[i-1][1]
                    end
                elsif knot[i][0] - knot[i-1][0] > 1
                    knot[i][0] = knot[i][0]-1
                    if (knot[i][1] - knot[i-1][1]).abs == 2
                        knot[i][1] = (knot[i][1] + knot[i-1][1])/2
                    else
                        knot[i][1] = knot[i-1][1]
                    end
                end
                if knot[i-1][1] - knot[i][1] > 1
                    knot[i][1] = knot[i][1]+1
                    if (knot[i][0] - knot[i-1][0]).abs == 2
                        knot[i][0] = (knot[i][0] + knot[i-1][0])/2
                    else
                        knot[i][0] = knot[i-1][0]
                    end
                elsif knot[i][1] - knot[i-1][1] > 1
                    knot[i][1] = knot[i][1]-1
                    if (knot[i][0] - knot[i-1][0]).abs == 2
                        knot[i][0] = (knot[i][0] + knot[i-1][0])/2
                    else
                        knot[i][0] = knot[i-1][0]
                    end
                end
            end
            travelled << [knot[length-1][0], knot[length-1][1]]
        end
    end
    travelled.count
end

p solve(2, input)
p solve(10, input)