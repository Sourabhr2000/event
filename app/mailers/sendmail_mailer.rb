class SendmailMailer < ApplicationMailer
    def welcome_user
        @user = params[:user]
        mail({
            to: @user.email,
            subject: 'Sourabh Rathore |22-06-2022 '
        })
        
    end
end
