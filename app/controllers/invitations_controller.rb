class InvitationsController < ApplicationController

  def index
    @invitations = Invitation.where(group_id: params[:group_id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.create(invitation_params)
  end

  def destroy
    @group = Group.find_by(id: params[:group_id])
    @invitation = Invitation.find_by(id: params[:id])
    @invitation.delete
    redirect_to group_invitations_path(@group)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:group_id, :sender_id, :recipient_id, :accept)
  end

end
