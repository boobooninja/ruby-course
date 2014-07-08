require 'active_record'
# require 'sqlite3'
require 'pg'

module Honkr
  module Databases
    class SQL

      class User < ActiveRecord::Base
        has_many :honks
      end

      class Honk < ActiveRecord::Base
        belongs_to :user
      end

      def persist_honk(honk)
        ar_honk = Honk.create(user_id: honk.user_id, content: honk.content)
        # Honkr::Honk.new(ar_honk.attributes['id'], ar_honk.attributes['user_id'], ar_honk.attributes['content'])
        honk.instance_variable_set("@id", ar_honk.attributes['id'])
      end

      def get_honk(id)
        ar_honk = Honk.find(id)
        Honkr::Honk.new(ar_honk.attributes['id'], ar_honk.attributes['user_id'], ar_honk.attributes['content'])
      end

      def persist_user(user)
        ar_user = User.create(username: user.username, password_digest: user.password_digest)
        # Honkr::User.new(ar_user.attributes['id'], ar_user.attributes['username'], ar_user.attributes['password_digest'])
        user.instance_variable_set("@id", ar_user.attributes['id'])
      end

      def get_user(id)
        ar_user = User.find(id)
        Honkr::User.new(ar_user.attributes['id'], ar_user.attributes['username'], ar_user.attributes['password_digest'])
      end
    end
  end
end
