#==========METHODS=============

module Enumerable
    
#========my_each method======== 
    
    def my_each
        i = 0
        self.size.times do
            yield(self[i])  
            i += 1      
        end
    self
    end
    
#========my_each_with_index method========   
    
    def my_each_with_index
        i = 0
          self.size.times do
            yield(self[i], i)
            i += 1
        end 
    self
    end
    
#========my_select method========     
    
    def my_select
        arr = []
        self.my_each do |x|
            if yield x
                arr.push x
            end
        end
        arr
    end
    
#========my_all? method========     
    
    def my_all?
        arr = []
        resul=true
        self.my_each do |x|
            if yield x
                arr.push x
            end
        end
        if arr.length == self.length
            resul = true
        else
            resul = false
        end
        resul
    end
    
#========my_any? method========     
    
    def my_any?
        res = false
        self.my_each do |x|
            if yield x
                res = true
                break
            end
        end
        res
    end

#========my_none? method========
    
    def my_none?
      res = true
        self.my_each do |x|
            if yield x
                res = false
                break
            end
        end
        res  
    end
    
#========my_count method========     
    
    def my_count value = nil
        count = 0
        self.my_each do|elem|
            if value 
                if elem == value 
                    count += 1
                end
            elsif block_given? 
                count += 1 if yield elem
            else
                count = self.length
            end 
        end
        count
    end
    
#========my_map method======== 
    
    def my_map
        arr = []
        self.my_each do |x| 
            arr.push yield x
        end
        arr
    end

#========my_map_2 method(TAKES A PROC)========
    
    def my_map_2(my_proc)
        arr = []
        self.my_each do |x|
          arr.push my_proc.call x
        end
        arr
    end
    
#========my_map_3 method(TAKES EITHER A PROC OR A BLOCK)========     
    
    def my_map_3 my_proc = nil
        arr = []
        self.my_each do |x|
            if my_proc == nil
               arr.push yield x 
            else
                arr.push my_proc.call x
            end
        end
        arr
    end

#========my_inject method======== 
    
    def my_inject index=0
        count = index
        self.my_each do|now|
            count = yield count, now
        end
        count
    end

end


#==================================TESTING INSTRUCTIONS============================
#Each test is organized in order, uncomment the test block to run the test you need
#==================================================================================


#=======MY EACH METHOD TEST========
#   array=[6,4,8,14,56,12,4,5,8]
#   array.my_each do |num|
#        num *= 2
#        print "#{num} " 
#   end
#==================================


#====== MY EACH WITH INDEX METHOD TEST ====================
#    array=[6,4,8,14,56,12,4,5,8]
#    array.my_each_with_index do |value, index|
#        puts "Array index #{index} has the value #{value}"
#    end
#==========================================================


#============== MY SELECT METHOD TEST =================
#    array=[6,2,7,14,9,12,4,5,8]
#    result = array.my_select do |n| n % 2 != 0 end
#    p result
#======================================================


#============== MY ALL METHOD TEST ====================
#    array=[6,2,4,14,6,12,4,3,8]
#    res=array.my_all? do |n| n % 2 == 0 end
#    print res
#======================================================


#============= MY ANY METHOD TEST =====================
#    array=[6,4,8,14,56,12,1,4]
#    res = array.my_any? do |n | n < 3 end
#    print res
#======================================================


#============= MY NONE METHOD TEST ====================
#    array=[6,4,8,14,56,12,4,1]
#    res = array.my_none? do |n | n % 2 == 1 end
#    print res
#======================================================


#============= MY COUNT METHOD TEST ===================
#   array = [6,4,8,14,56,12,4,5,8,8,8,8,4,7,8,7,5]
#   #res = array.my_count
#   #res = array.my_count (8)
#   res = array.my_count() do|n| n % 2 == 1  end
#   p res
#======================================================


#============== MY MAP METHOD TEST ==================
#    array=[6,4,8,14,56,12,4,5,8]
#    res = array.my_map do |n| n * 2 end
#    p res
#====================================================


#============== MY MAP 2 METHOD (TAKES A PROC) ==========
#   array=[6,4,8,14,56,12,4,5,8]
#   my_proc = Proc.new do |n| n * 2 end
#   res = array.my_map_2(my_proc)
#   p res
#========================================================


#============== MY MAP 3 METHOD (TAKES EITHER A PROC OR A BLOCK)=================
#   array=[6,4,8,14,56,12,4,5,8]
#   my_proc = Proc.new do |n| n * 2 end
#   res = array.my_map_3 do |n| n * 3 end
#   res = array.my_map_3(my_proc)
#   p res
#=================================================================================


#=============== MY INJECT TEST =====================
#   def multiply_els(array)
#       array.my_inject(1) do |total, n|total * n end
#   end
#   array=[3,2,2,5]
#   puts multiply_els(array)
#====================================================