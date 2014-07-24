module DoubleDog
  class FindOrder
    def run(id)
      order = DoubleDog.db.get_order(id)
      return success(order: order)
    end

  private

    def failure(error_name)
      return :success? => false, :error => error_name
    end

    def success(data)
      return data.merge(:success? => true)
    end
  end
end
