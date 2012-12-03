module ApplicationHelper
  def current_month
    Date.today.strftime("%B")
  end

  def short_date(date)
    date.strftime("%m/%-d")
  end
end
