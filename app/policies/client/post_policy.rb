class Client::PostPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    check_for_client
  end

  def new?
    check_for_client
  end

  def create?
    check_for_client
  end

  def edit?
    check_for_client
  end

  def update?
    check_for_client
  end

  def destroy?
    check_for_client
  end

  private

    def check_for_client
      user.has_role? :client
    end
end