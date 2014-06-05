class CarStats
  def self.calc_top_color(cars)
    car_hash(cars).max_by {|color,count| count}.first
  end

  def self.calc_bottom_color(cars)
    car_hash(cars).min_by {|color,count| count}.first
  end

  def self.car_hash(cars)
    # cars.each_with_object(Hash.new(0)) do |car,count|
    #   count[car.color] += 1
    # end

    cars.inject(Hash.new(0)) do |hash, car|
      hash[car.color] += 1
      hash
    end
  end
end
