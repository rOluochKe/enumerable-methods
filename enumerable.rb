#!/usr/bin/ruby

module Enumerable
    #each
    def my_each
        i = 0
        while i < self.length
            yield(self[i])
            i += 1
        end
    end

    #each_with_index
    def my_each_with_index
        i = 0
        while i < self.count
            yield(self[i],i)
            i += 1
        end

    end

    #select
    def my_select 
        result = []
        self.my_each {|i| result.push(i) if yield(i)}
        result
    end
    
    #all?
    def my_all?
        self.my_each {|i| return false unless yield(i)}
        true
    end

    #any?
    def my_any?
        result = false
        self.my_each {|i| result = true if yield(i)}
        result
    end

    #none
    def my_none?
        result = true
        self.my_each {|i| result = false if yield(i)}
        result
    end

    #count
    def my_count
        total = 0
        self.my_each{total += 1}
        total
    end

    #map 
    def my_map(&block)
        result = []
        self.my_each {|i| result.push(block.call(i))}
        return result
    end

    #inject
    def my_inject
        m = self[0]
        self.my_each {|i| m = yield(m, i)}
        m
    end
end

#multiply_els
def multiply_els(arr)
    arr.my_inject {|x,y| x*y}
end

array = [2,4,5]
puts multiply_els(array)