sizes = Hash.new(0)
cwd = nil
total_size = 0

input = ARGF.each_line.map do |line|
    line.rstrip!
    case line
    when "$ cd /"
        cwd = ['']
    when "$ cd .."
        cwd.pop
    when /^(\d+) /
        size = $1.to_i
        total_size += size
        path = ''
        cwd.each{|dir|
            path += "/#{dir}"
            sizes[path] += size
        }
    when /^\$ cd (.+)$/
        cwd << $1
    end
end

puts sizes.select{|k, v| v <= 100_000}.values.sum
need_to_free = 30000000 - (70000000 - total_size)
puts sizes.sort_by{|k,v| v}.find{|k,v| v > need_to_free}.last
