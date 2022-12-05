input = ARGF.each_line.map do |line|
    line.rstrip
end

first_part = true
columns = []
procedure = []
input.each do |line|
    if line =~ /^[0-9 ]+$/
        first_part = false
        next
    end
    if first_part
        cubes = line.scan(/.{3}\s?/)
        cubes.each_with_index do |m, i|
            if m =~ /\[([A-Z])\]/
                columns[i] ||= []
                columns[i] << $1
            end
        end
    else
        if m = line.match(/^move (\d+) from (\d+) to (\d+)$/)
            procedure << m.captures.map(&:to_i)
        end
    end
end

columns_backup = columns.map{|col| col.dup}

procedure.each do |count, from, to|
    count.times do
        c = columns[from-1].shift
        columns[to-1].unshift(c)
    end
end
puts columns.map(&:first).join

columns = columns_backup

procedure.each do |count, from, to|
    c = columns[from-1].shift(count)
    columns[to-1].unshift(*c)
end
puts columns.map(&:first).join
