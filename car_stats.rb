class CarStats
  def self.calc_top_color(cars)
    car_hash = cars.each_with_object(Hash.new(0)) {|car,count| count[car.color] += 1}
    top_color = nil
    top_count = 0
    car_hash.each do|color,count|
      if count > top_count
        top_count = count
        top_color = color
      end
    end

    top_color
  end

  def self.calc_bottom_color(cars)
    car_hash = cars.each_with_object(Hash.new(0)) {|car,count| count[car.color] += 1}
    bottom_color = nil
    bottom_count = 100
    car_hash.each do|color,count|
      if count < bottom_count
        bottom_count = count
        bottom_color = color
      end
    end

    bottom_color
  end
end
