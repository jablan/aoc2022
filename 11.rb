index = 0
items = {}
op = {}
tests = {}
out = {}
totals = Hash.new(0)

input = ARGF.each_line.map do |line|
    line.rstrip!
    case line
    when ''
        index += 1
    when /Starting items: (.+)/
        items[index] = $1.split(', ').map(&:to_i)
    when /Operation: new = (.+)/
        op[index] = $1.gsub('new', 'newv')
    when /Test: divisible by (\d+)/
        tests[index] = $1.to_i
    when /If true: throw to monkey (\d+)/
        out[index] ||= {}
        out[index][true] = $1.to_i
    when /If false: throw to monkey (\d+)/
        out[index] ||= {}
        out[index][false] = $1.to_i
    end
end


def solve(items:, tests:, op:, out:, iter:, worry_limit:)
    counts = Hash.new(0)

    items = items.transform_values{|v| v.dup} # cheap deep_dup

    divider = tests.values.inject(&:*)

    new_items = {}
    iter.times do
        tests.count.times do |i|
            next unless items[i]
            items[i].each do |old|
                counts[i] += 1
                newv = binding.eval(op[i])
                if worry_limit
                    newv %= divider
                else
                    newv /= 3
                end
                res = newv % tests[i] == 0
                newm = out[i][res]
                if newm > i
                    items[newm] ||= []
                    items[newm] << newv
                else
                    new_items[newm] ||= []
                    new_items[newm] << newv
                end
            end
        end
        items = new_items
        new_items = {}
    end

    counts.values.sort.last(2).inject(&:*)
end

puts solve(items: items, tests: tests, op: op, out: out, iter: 20, worry_limit: false)

puts solve(items: items, tests: tests, op: op, out: out, iter: 10_000, worry_limit: true)
