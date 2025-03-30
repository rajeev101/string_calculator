class StringCalculator
  def self.add(num)
    return 0 if num.empty?

    delimiter, num = extract_delimiter(num)
    number_list = num.split(/#{delimiter}/).map(&:to_i)
    
    negative_exception(number_list)
    number_list.sum
  end

  private

  def self.extract_delimiter(num)
    return [/[,\n]/, num] unless num.start_with?("//")
    delimiter, num = num.split("\n", 2)
    [Regexp.new(Regexp.escape(delimiter[2..])), num]
  end

  def self.negative_exception(number_list)

    negatives = number_list.select(&:negative?)
    
    raise "negative number not allowed #{negatives.join(",")}" if negatives.any?
  end
end

begin
  puts StringCalculator.add("-1,-5")
rescue => e
  puts e.message
end

puts StringCalculator.add("")          # Output: 0
puts StringCalculator.add("1")         # Output: 1
puts StringCalculator.add("1,5")       # Output: 6
puts StringCalculator.add("1\n2,3")    # Output: 6
puts StringCalculator.add("//;\n1;2")  # Output: 3