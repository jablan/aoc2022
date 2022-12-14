input = ARGF.each_line.map do |line|
    line.split(' -> ').map{|coords|
        coords.split(',').map(&:to_i)
    }
end

def create_maze(input)
    maze = {}
    max_y = 0

    input.each do |line|
        line.each_cons(2) do |(x1, y1), (x2, y2)|
            max_y = y1 if y1 > max_y
            max_y = y2 if y2 > max_y
            Range.new(*[y1, y2].sort).each do |y|
                Range.new(*[x1, x2].sort).each do |x|
                    maze[[x, y]] = '#'
                end
            end
        end
    end

    [maze, max_y]
end

def count_sand maze, max_y: nil, bottom: false
    res = (1..100_000).find{ |i|
        x = 500
        y = 0

        while(true) do
            if !maze[[x, y+1]]
                y += 1
            elsif !maze[[x-1, y+1]]
                y += 1
                x -= 1
            elsif !maze[[x+1, y+1]]
                y += 1
                x += 1
            else
                break
            end
            break if y > max_y
        end
        maze[[x, y]] = 'o'

        if bottom
            y == 0
        else
            y > max_y
        end
    }
    bottom ? res : res - 1
end

maze, max_y = create_maze(input)
p count_sand(maze, max_y: max_y, bottom: false)

maze, max_y = create_maze(input)
p count_sand(maze, max_y: max_y, bottom: true)
