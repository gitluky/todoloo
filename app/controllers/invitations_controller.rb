class InvitationsController < ApplicationController

def new
    @users = User.all
    @group = Group.find_by(id: params[:group_id])
    @invitation = @group.invitations.build
  end

  def create
    @group = Group.find_by(id: params[:group_id])
    @invitation = @group.invitations.build(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @invitation = Invitation.find_by(id: params[:id])
    @group = @invitation.group
    if !!params[:invitation][:accept]
      @group.users << current_user
      @invitation.destroy
    else
      @invitation.destroy
    end
    redirect_to root_path
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :group_id)
  end

end
