module Enumerable
  def my_each
    return to_enum unless block_given?
    for item in self
      yield(item)
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?
    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?
    result = []
    my_each do |item|
      result << item if yield(item)
    end
    result
  end

  def my_all?
    if block_given?
      my_each { |item| return false unless yield(item) }
    else
      my_each { |item| return false unless item }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |item| return true if yield(item) }
    else
      my_each { |item| return true if item }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |item| return false if yield(item) }
    else
      my_each { |item| return false if item }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(item) }
    elsif arg.nil?
      count = size
    else
      my_each { |item| count += 1 if item == arg }
    end
    count
  end

  def my_map
    return to_enum unless block_given?
    result = []
    my_each do |item|
      result << yield(item)
    end
    result
  end

  def my_inject(initial = nil)
    if initial.nil?
      memo = first
      start_idx = 1
    else
      memo = initial
      start_idx = 0
    end
    my_each_with_index do |item, index|
      next if index < start_idx
      memo = yield(memo, item)
    end
    memo
  end
end

# Now, define my_each on the Array class
class Array
  include Enumerable

  def my_each
    return to_enum unless block_given?
    for item in self
      yield(item)
    end
    self
  end
end