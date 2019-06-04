class InvitationsController < ApplicationController

  def index
    @invitations = Invitation.where(group_id: params[:group_id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      redirect_to group_invitations_path(params[:group_id])
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
    redirect_to group_invitations_path(@group)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :group_id)
  end

end
