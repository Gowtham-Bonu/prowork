class SwitchPolicy
  attr_reader :user, :record


  def initialize(user, _record)
    @user = user
  end

  def land?
    user.has_role? :client || :freelancer
  end

  def become_freelancer?
    check_for_client
  end

  def switch_as_client?
    user.has_role? :freelancer
  end

  def switch_as_freelancer?
    check_for_client
  end

  private

  def check_for_client
    user.has_role? :client
  end
end