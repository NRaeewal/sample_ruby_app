class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts

  end



  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    puts params
    @user = User.find(params[:id])

  end

  def following
    @title = "Following"
    puts params
    @user  = Relationship.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private


  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # # Before filters

    # # Confirms the correct user.
    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_url) unless current_user?(@user)
    # end

    # # Confirms an admin user.
    # def admin_user
    #   redirect_to(root_url) unless current_user.admin?
    # end


end
