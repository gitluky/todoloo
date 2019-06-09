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

  def validate_current_user
    if current_user.id != params[:user_id].to_i
      redirect_to user_groups_url(current_user)
    end
  end

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :image )
  end

end
