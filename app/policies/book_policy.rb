class BookPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      user.books
    end

    private

    attr_reader :user, :scope
  end
end