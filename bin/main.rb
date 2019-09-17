#!usr/bin/ruby
# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    length = self.length
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    length = self.length
    while i < length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select(&block)
    arr = []
    my_each { |e| arr.push(e) if block.call(e) }
    arr
  end

  def my_all?(&block)
    result = true
    if block
      my_each { |e| result = false unless yield(e) }
    else
      my_each { |e| result = false unless e }
    end
    result
  end

  def my_any?(&block)
    result = false
    if block
      my_each { |e| result = true if yield(e) }
    else
      my_each { |e| result = true if e }
    end
    result
  end

  def my_none?(&block)
    result = true
    if block
      my_each { |e| result = false if yield(e) }
    else
      my_each { |e| result = false if e }
    end
    result
  end

  def my_count(val = nil, &block)
    result = 0
    if block && !val
      my_each { |e| result += 1 if yield(e) }
    elsif !val
      my_each { result += 1 }
    else
      my_each { |e| result += 1 if val == e }
    end
    result
  end

  def my_map(proc = nil, &block)
    arr = []
    if proc
      my_each { |e| arr.push(proc.call(e)) }
    else
      my_each { |e| arr.push(block.call(e)) }
    end
    arr
  end

  def my_inject(val = nil, &block)
    if instance_of? Range
      last = self.last
      first = self.first
      result = val
      i = first
      while i <= last
        result = block.call(result, i) unless i == first
        i += 1
      end
    else
      i = 1
      result = self[0]
      result = block.call(result, val) if val
      while i < length
        result = block.call(result, self[i])
        i += 1
      end
    end
    result
  end
end

# test function for inject
def multiply_els(arr)
  p arr.my_inject(1) { |product, v| product * v }
end