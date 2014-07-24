module DoubleDog
  class FindOrderByUser
    def run(params)
      puts "params: #{params}"
      return failure(:not_admin) unless admin_session?(params[:session_id])
      puts "admin_session?: true"

      orders = DoubleDog.db.all_orders

      puts "orders: #{orders}"

      user_orders = orders.select {|order| order.employee_id.to_s == params[:id].to_s}
      return success(orders: user_orders)
    end

    def admin_session?(session_id)
      user = DoubleDog.db.get_user_by_session_id(session_id)
      user && user.admin?
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
