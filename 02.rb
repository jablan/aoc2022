require 'pry'

V = {
    'X' => 1,
    'Y' => 2,
    'Z' => 3,
    'A' => 1,
    'B' => 2,
    'C' => 3,
}

R = {
    'X' => 0,
    'Y' => 3,
    'Z' => 6
}

def calc_result(l, r)
    case V[r] - V[l]
    when 1, -2
        6
    when 0
        3
    else
        0
    end
end

def need_to_play(l, r)
    v = V[l]
    v = case r
    when 'X'
        v - 1
    when 'Y'
        v
    when 'Z'
        v + 1
    end
    v = 1 if v > 3
    v = 3 if v < 1
    v
end

moves = ARGF.each_line.map do |line|
    line.split(' ')
end

p moves.inject(0){ |sum, (l, r)|
    sum + V[r] + calc_result(l, r)
}

p moves.inject(0){ |sum, (l, r)|
    sum + R[r] + need_to_play(l, r)
}
