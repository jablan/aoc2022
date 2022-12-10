input = ARGF.each_line.map do |line|
    line.rstrip
end

x = 1
c = 1
@sum = 0
@xpos = 1

def tick(c, x)
    # puts "xpos: #{@xpos}, x: #{x}"
    if @xpos >= x && @xpos < x + 3
        print '#'
    else
        print '.'
    end
    @xpos += 1
    if @xpos > 40
        puts
        @xpos = 1
    end

    if (c+20) % 40 == 0
        @sum += x * c
    end
end

input.each do |line|
    ci = 0
    xi = 0
    case line
    when 'noop'
        tick(c, x)
        c += 1
    when /addx (-?\d+)/
        tick(c, x)
        c += 1
        tick(c, x)
        c += 1
        x += $1.to_i
    end
end

p @sum
