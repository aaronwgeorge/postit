module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_date(date)
    date.strftime("%l:%M%P %Z on %-m/%d/%Y")
  end
end
