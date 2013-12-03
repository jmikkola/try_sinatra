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

def n_to_digits(n)
    digits = []
    while n > 0
        digits << n % 10
        n /= 10
    end
    digits.reverse!
end

def array_is_palindrome?(arr)
    len = arr.length
    (0..len/2).each do |i|
        return false if arr[i] != arr[len - i - 1]
    end

    true
end

def n_is_palindrome?(n)
    array_is_palindrome?(n_to_digits n)
end

def euler_4
    max = 0

    (100..999).each do |i|
        (i..999).each do |j|
            n = i * j
            if n > max and n_is_palindrome?(n)
                max = n
            end
        end
    end

    max
end

def gcd(a, b)
    if b == 0
        a
    elsif b > a
        gcd(b, a)
    else
        gcd(b, a % b)
    end
end

def lcm(a, b)
    a * b / gcd(a, b)
end

def euler_5
    (1..20).inject { |prod, i| lcm(prod, i) }
end
