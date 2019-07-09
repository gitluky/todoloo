module GroupsHelper

  def display_banner(group)
     if group.image.attached?
       image_tag url_for(group.image), class: "group-banner"
    else
       image_tag url_for("placeholder-banner.png"), class: "group-banner"
    end
  end

end
