class InvitationsController < ApplicationController

  before_action :set_group
  before_action :set_invitation, only: [:accept, :destroy, :set_group]
  before_action :check_edit_privileges, only: [:destroy]
  before_action :validate_user_group_membership, only: [:new, :create]

  def new
    @users = User.all
    @invitation = @group.invitations.build
  end

  def create
    @users = User.all
    @invitation = @group.invitations.build(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      redirect_to group_path(@group), flash: { message: 'Invitation Sent.'}
    else
      render :new, flash: { message: 'Invitation not sent.' }
    end
  end

  def accept
    @group.users << current_user
    @invitation.destroy
    redirect_to root_path
  end

  def destroy
    @invitation.destroy
    redirect_to group_path(@group)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :group_id)
  end

  def set_invitation
    @invitation = Invitation.find_by(id: params[:id])
  end

  def set_group
    if params[:group_id]
      @group = Group.find_by(id: params[:group_id])
    else
      @group = @invitation.group
    end
  end

  def check_edit_privileges
    if !current_user.is_admin?(@group) && current_user != @invitation.sender
      redirect_to group_path(@group), flash: { message: 'You do not have the rights to perform action.' }
    end
  end


end
