class InvitationsController < ApplicationController

def new
    @users = User.all
    @group = Group.find_by(id: params[:group_id])
    @invitation = @group.invitations.build
  end

  def create
    @users = User.all
    @group = Group.find_by(id: params[:group_id])
    @invitation = @group.invitations.build(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      redirect_to group_path(@group), flash: { message: 'Invitation Sent.'}
    else
      render :new, flash: { message: 'Invitation not sent.' }
    end
  end

  def accept
    @invitation = Invitation.find_by(id: params[:id])
    @group = @invitation.group
    @group.users << current_user
    @invitation.destroy
    redirect_to root_path
  end

  def destroy
    @invitation = Invitation.find_by(id: params[:id])
    @group = @invitation.group
    if current_user.is_admin?(@group)
      @invitation.destroy
      redirect_to group_path(@group)
    else
      @invitation.destroy
      redirect_to root_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :group_id)
  end

end
