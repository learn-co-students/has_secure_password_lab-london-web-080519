class SessionsController < ApplicationController
    
    def new
        @user = User.new
    end

    def create
        user = User.find_by(name: params[:user][:name])
        user = user.try(:authenticate, params[:user][:password])
        if user
            session[:user_id] = user.id
            @user = user
            redirect_to welcome_path
        else
            flash[:errors] = "something went wrong"
            redirect_to login_path
        end
    end

    private

    def login_params
        params.require
    end

end
