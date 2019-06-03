class InvitationsController < ApplicationController

  def index
    @invitations = Invitation.where(group_id: params[:group_id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @group = Group.find_by(id: params[:group_id])
    @invitation = Invitation.create(invitation_params)
    @invitation.group = @group
    @invitation.sender = current_user
    if @invitation.save
      redirect_to group_invitations_path(@group)
    else
      render :new
    end
  end

  def destroy
    @group = Group.find_by(id: params[:group_id])
    @invitation = Invitation.find_by(id: params[:id])
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
    params.require(:invitation).permit(:recipient_email)
  end

end
