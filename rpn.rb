class RpnError < RuntimeError
end

def eval_rpn(expression)
    begin
        rpn(expression)
    rescue Exception => ex
        ex.message
    end
end

def rpn(expression)
    operators = {
        '+' => lambda { |left, right| left + right },
        '-' => lambda { |left, right| left - right },
        '*' => lambda { |left, right| left * right },
        '/' => lambda { |left, right| left / right },
    }
    stack = []

    expression.split.each do |part|
        if operators.has_key? part
            raise RpnError, "Too few numbers" unless stack.length >= 2
            right = stack.pop
            left = stack.pop
            stack << operators[part][left, right]
        else
            stack << Float(part)
        end
    end

    if stack.length < 1
        raise RpnError, "Too few numbers"
    elsif stack.length > 1
        raise RpnError, "Too many numbers"
    end

    return stack[0]
end
