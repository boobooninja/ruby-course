# In some countries of former Soviet Union there was
# a belief about lucky tickets. A transport ticket
# of any sort was believed to posess luck if sum of
# digits on the left half of its number was equal to
# the sum of digits on the right half. Here are
# examples of such numbers:
#
# 003111    #         3 = 1 + 1 + 1
# 813372    # 8 + 1 + 3 = 3 + 7 + 2
# 17935     #     1 + 7 = 3 + 5
# 56328116  # ???
#
# Such tickets were either eaten after being used
# or collected for bragging rights.
#
# Read the tests carefully and make them pass.
#
# Credit to SundaySalsa on codewars.com for coming
# up with this problem.

class Lucky
  def self.check(str)
    raise :error if str.size == 0
    rts = str.scan(/[a-zA-Z]|\s/)
    raise :error if rts.size > 0

    digits = str.scan(/\d/)
    x = digits.size / 2

    y, z = digits[0..x-1], digits[-x..-1]

    [y,z].each do |a|
      a.map! {|b| b.to_i}
    end

    y.inject(:+) == z.inject(:+)
  end
end
