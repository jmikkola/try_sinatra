def euler_1
    numbers = (1...1000).select { |i| i % 3 == 0 or i % 5 == 0 }
    numbers.inject(0) { |sum, n| sum + n }
end

def fibonacci
    a, b = 0, 1
    while true
        yield a
        a, b = a + b, a
    end
end

def euler_2
    sum = 0
    fibonacci do |n|
        sum += n if n.even?
        break if n > 4000000
    end
    sum
end

def euler_3
    number = 600851475143
    max = Integer(1 + Math.sqrt(number))
    max_factor = 0

    (2..max).each do |n|
        while number % n == 0
            max_factor = n
            number /= n
        end
    end

    max_factor
end
