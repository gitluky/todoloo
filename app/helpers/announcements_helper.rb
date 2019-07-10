module AnnouncementsHelper
  def last_updated(announcement)
    announcement.updated_at.strftime('%B, %d, %Y')
  end

  def date_created(announcement)
    announcement.created_at.strftime('%B, %d, %Y')
  end
end
