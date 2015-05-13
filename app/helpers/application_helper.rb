module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_date(date)
    if logged_in? && !current_user.time_zone.blank?
      date = date.in_time_zone(current_user.time_zone)
    end

    date.strftime("%l:%M%P %Z on %-m/%d/%Y")
  end
end
