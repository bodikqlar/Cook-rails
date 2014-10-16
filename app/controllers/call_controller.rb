class CallController < ApplicationController
  def login
    logger.info "LOGIN:#{params.inspect}"

    if request.post?
      logger.info "LOGIN:POST"
      user = User.authenticate(params[:name], params[:password])
      logger.info "USER:#{user.inspect}"
      if user
        flash.now[:notice] = "Successful login"
        session[:user_id] = user.id
        redirect_to(:action => "index")
      else
        flash.now[:alert] = "Invalid user/password combination"
      end
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index
    @me = current_user
    @friends = User.all.select{ |u| u != @me }
  end
end
