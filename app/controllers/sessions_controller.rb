class SessionsController < ApplicationController

    def new

    end

    #create our new session
    def create
        #from has_secure_password docs -- try to find by the passed-in params of user, try and authetnicate the password
        @user = User.find_by(name: params[:user][:name]).try(:authenticate, params[:user][:password]) 
        #redirect them back to the controller unless the above returned a truthy value (e.g. it knows what @user is)
        return redirect_to controller: 'users', action: 'new' unless !!@user
        #set the session user id to the found @user.id
        session[:user_id] = @user.id
        #then redirect them to the users controller, welcome
        redirect_to(controller: 'users', action: 'welcome')
    end

    def destroy
        session.delete :name
    end
end
