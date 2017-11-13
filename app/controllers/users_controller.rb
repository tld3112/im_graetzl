class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @graetzl = Graetzl.find_by_slug(params[:graetzl_id])
    redirect_to([@user.graetzl, @user], status: 301) and return if wrong_graetzl?(@user, @graetzl)
    @wall_comments = @user.wall_comments.includes(:user, :images).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      bypass_sign_in @user
      redirect_to [@user.graetzl, @user], notice: 'Profil gespeichert!'
    else
      render :edit
    end
  end

  private

  def wrong_graetzl?(user, graetzl)
    graetzl.nil? || user.graetzl != graetzl
  end

  def user_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params.
      require(:user).
      permit(:email,
        :password,
        :first_name,
        :last_name,
        :website,
        :bio,
        :newsletter,
        :role,
        :avatar, :remove_avatar,
        :cover_photo, :remove_cover_photo)
  end
end
