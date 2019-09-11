#!usr/bin/ruby
# frozen_string_literal: true

module Enumerable
  # my_each method
  def my_each
    counter = 0
    while counter < size
      yield(self[counter])
      counter += 1
    end
  end
            
  # my_each_with_index 
  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end
            
  # my_select  
  def my_select
    output = []
    my_each { |ele| output << ele if yield(ele) }
    output
  end
        
  # my_all?     
  def my_all?
    all_passed = true
    self.my_each do |i|
      if !yield(i)
        all_passed = false
        break
      end
    end
    all_passed
  end
        
  # my_any?    
  def my_any?
    any = false
    self.my_each do |i|
      if yield(i)
        any = true
        break
      end
    end
    any
  end

  # my_none?  
  def my_none?
    none = true
    self.my_each do |i|
      if yield(i)
        none = false
        break
      end
    end
    none
  end
        
  # my_count  
  def my_count(num = nil)
    count = 0
    if !num && !block_given?
      count = self.length
    elsif num
      for i in self
        if i == num
          count += 1
        end
      end
    else
      for i in self
        if yield(i)
          count += 1
        end
      end
    end
    count
  end
  end
        
  # my_map
  def my_map(&procs)
    output = []
    my_each { |ele| output << (procs.nil? ? yield(ele) : procs.call(ele)) }
    output
  end

  # my_inject
  def my_inject(memo = nil, sym = nil)
    return my_inject(nil, memo) if memo.is_a? Symbol
    return my_inject(memo) { |mem, e| :+.to_proc.call(mem, e) } unless sym.nil?

    my_each { |e| memo = memo.nil? ? first : yield(memo, e) }
    memo
  end
end

# Test my_inject method
def multiply_els(arr)
  arr.my_inject { |memo, item| memo * item }
end