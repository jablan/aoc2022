require 'set'

input = ARGF.each_line.map do |line|
    line.rstrip.split(',').map(&:to_i)
end

min_coord = [100,100,100]
max_coord = [0,0,0]

edges = []
input.each do |coords|
    (0..2).each do |dim|
        min_coord[dim] = coords[dim] if coords[dim] < min_coord[dim]
        max_coord[dim] = coords[dim] if coords[dim] > max_coord[dim]

        [-5, 5].each do |inc|
            edges << coords.each_with_index.map { |c, d|
                d == dim ? c * 10 + inc : c * 10
            }
        end
    end
end

free_edges = edges.group_by{|e| e}.select{|_e, points| points.count == 1}.keys

p free_edges.count

min_coord.map!{|c| c - 1}
max_coord.map!{|c| c + 1}
puts "min_coord: #{min_coord}"
puts "max_coord: #{max_coord}"

def around(coords)
    (0..2).flat_map { |dim|
        [-1,1].map { |inc|
            coords.each_with_index.map {|c, d|
                d == dim ? c + inc : c
            }
        }
    }
end

def outside?(point, min_coord, max_coord)
    point.each_with_index.any?{|c, d| c < min_coord[d] || c > max_coord[d]}
end

def fill_around(input, min_coord, max_coord)
    checked = Set.new
    to_check = [min_coord]
    while !to_check.empty?
        curr = to_check.pop
        checked << curr
        next_to_check = around(curr)
        to_check += next_to_check.reject{|point| checked.include?(point) || outside?(point, min_coord, max_coord) || input.include?(point)}
    end
    checked
end

def touches?(edge, water)
    res = water.any?{|wc|
        wc.each_with_index.inject(0) {|acc, (c, dim)|
            acc + (c*10 - edge[dim]).abs
        } == 5
    }
end

water = fill_around(input, min_coord, max_coord)

p free_edges.select{|edge| touches?(edge, water)}.count
