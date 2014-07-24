module DoubleDog
  class FindUser
    def run(id)
      user = DoubleDog.db.get_user(id)
      return success(user: user)
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
