require './euler'

class EulerView
    def initialize
        @solutions = {
            1 => euler_1,
            2 => euler_2,
            3 => euler_3,
            4 => euler_4,
            5 => euler_5,
        }
    end

    def render(problem)
        values = {
            :prob_no => problem,
            :solved => @solutions.keys,
        }

        prob_num = Integer(problem)
        if @solutions.has_key?(prob_num)
            values[:answer] = @solutions[prob_num]
            template = :project_euler
        else
            template = :no_solution
        end

        return template, values
    end
end
