class UsersController < ApplicationController
    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update,:destroy]
    before_action :require_admin,only: [:destroy]
    def index
        @users=User.all
    end
    def show
        @user=User.find(params[:id])
        @registrations=@user.registrations
        @liked_events=@user.liked_events
    end
    def new
        @user=User.new
    end
    def create
        @user= User.new(user_params)
        if @user.save
            SendmailMailer.with(user: @user).welcome_user.deliver_now
            session[:user_id] = @user.id
            redirect_to @user, notice: "Thanks for signing up!"
        else  
            render :new, status: :unprocessable_entity
        end
    end
    def edit
        @user=User.find(params[:id])
    end
    def update
        @user=User.find(params[:id])
        if @user.update(user_params)
            flash[:alert]="successfully updated"
            redirect_to @user
        else
            render :edit
        end
    end
    def destroy
        @user=User.find(params[:id])
        @user.destroy
        session[:user_id]=nil
        redirect_to root_path,status: :see_other, alert: "your Account Has deleted..!"
    end

    private
    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def require_correct_user
        @user = User.find(params[:id])
        unless current_user == @user
          redirect_to root_url,notice: "you can't edit or delete another user profile"
        end
    end
    
end
