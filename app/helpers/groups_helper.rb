module GroupsHelper

  def display_banner(group)
     if group.image.attached?
       image_tag url_for(group.image), class: "group-banner"
    else
       image_tag url_for("placeholder-banner.png"), class: "group-banner"
    end
  end

  def validate_logged_in
    if !logged_in?
      redirect_to login_path
    end
  end

  def tasks_category_title(title_string, tasks_array)
    title_string + " (#{tasks_array.count.to_s})" + ':'
  end

end
