module UsersHelper

  def display_avatar(user, size)
     if user.avatar.attached?
       image_tag url_for(user.avatar), class: "avatar-#{size}"
    else
       image_tag url_for("default_avatar.png"), class: "avatar-#{size}"
    end
  end
end
