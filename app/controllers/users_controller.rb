class UsersController < ApplicationController
#require_login before accessing the index or welcome
before_action :require_login
#except for new or create (in case they want to sign up)
skip_before_action :require_login, only: [:new, :create]

    def index

    end

    def new
        @user = User.new
    end

    def create
        #try to create them
        @user = User.create(user_params)
        #redirect them back to keep trying unless it saves - secure_password doesn't allow it to be saved unless the confirmation matches
        return redirect_to controller: 'users', action: 'new' unless @user.save
        #set the session user_id to this newly created user to automatically log them in
        session[:user_id] = @user.id          
        #send them to the welcome page
        redirect_to(controller: 'users', action: 'welcome')
    end

    def welcome
        #custom welcome page, didn't want to define a new controller...
        @user = User.find(params[:id])
        render "welcome"
    end

    private

    #set a require_login to block instant access to the welcome page
    def require_login
        #redirect them to the sessions login (in production would need to be created) - unless the session includes the user_id
        redirect_to(controller: 'sessions', action: 'new') unless session.include? :user_id
    end

    #our ever-loved strong params
    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end
    
end
