module Honkr
  class User

    attr_reader :id, :username, :password_digest

    def initialize(id, username, password_digest=nil)
      @id = id
      @username = username
      @password_digest = password_digest
    end

    def update_password(password)
      @password_digest = Digest::SHA1.hexdigest(password)
    end

    def has_password?(password)
      incoming_password = Digest::SHA1.hexdigest(password)
      incoming_password == @password_digest
    end
  end
end
