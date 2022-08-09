class SessionsController < ApplicationController
    def new

    end
    def create
        user=User.find_by(email:params[:email])|| User.find_by(name: params[:email])
        puts user
        if user && user.authenticate(params[:password])
            session[:user_id]=user.id
            redirect_to (session[:intended_url] || user),notice: "Welcome back, #{user.name}!"
            session[:intended_url] = nil
        else
            flash[:alert]= "Invalid Email Or Password..!"
            render :new , status: :unprocessable_entity 
        end
    end
    def destroy
        session[:user_id] = nil
        redirect_to events_path,notice: "successfully loged out.."
    end
end
