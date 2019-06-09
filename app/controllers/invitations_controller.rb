class InvitationsController < ApplicationController

  def index
    @invitations = current_user.received_invitations
  end

  def new
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
    if params[:invitation][:accept]
      @group.users << current_user
      @invitation.delete
    else
      @invitation.delete
    end
    redirect_to user_groups_path
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :group_id)
  end

end
