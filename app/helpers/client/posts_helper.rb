module Client::PostsHelper
  def get_time(past_date)
    days = (Date.today-past_date.to_date).to_i
    if days == 0
      'today'
    elsif days == 1
      '1 day ago'
    else
      "#{days} days ago"
    end
  end
end