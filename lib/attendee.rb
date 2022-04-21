class Attendee

attr_reader :name, :budget
    def initialize(attributes)
        @name = attributes[:name]
        @budget = attributes[:budget].reverse.chop!.reverse.to_i
    end

    # def budget
    #     @budget_string.gsub("$","").to_i
    # end --> alternative to budget variable, maintains original version in case you need access to the other version again
end