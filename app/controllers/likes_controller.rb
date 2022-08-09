class LikesController < ApplicationController
    def create
        @event=Event.find_by!(slug: params[:event_id])
        @like=@event.likes.create!(user:current_user)
        redirect_back(fallback_location: root_path, status: :see_other)
    end
    def destroy
        like=current_user.likes.find(params[:id])
        puts like
        like.destroy

        # event=Event.find(params[:event_id])
        # redirect_to event
        redirect_back(fallback_location: root_path, status: :see_other)
    end
end
