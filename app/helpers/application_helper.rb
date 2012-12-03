module ApplicationHelper
  def current_month
    Date.today.strftime("%B")
  end
end
