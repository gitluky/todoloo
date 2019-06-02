module UsersHelper

  def display_avatar(user)
     if user.avatar.nil?
       image_tag url_for(user.avatar), class: 'avatar'
    else
       image_tag url_for("default_avatar.png"), class: 'avatar'
    end
  end
end
