ARGF.each_line.map(&:strip)
    .slice_when{|line| line.empty?}
    .map{|elf| elf.map(&:to_i).sum}
    .sort.tap do |sorted|
        p sorted.last
        p sorted.last(3).sum
    end
