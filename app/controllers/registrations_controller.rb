class RegistrationsController < ApplicationController
    before_action :require_signin
    before_action :set_event
    def index
        # @event=Event.find(params[:event_id])
        # set_value --because we defined method below
        @registrations=@event.registrations
    end
    def new
        # @event=Event.find(params[:event_id])
        # set_value --because we defined method below
        @registration=@event.registrations.new
    end
    # def show
    # end
    def create
        # @event=Event.find(params[:event_id])
        # set_value -- because we defined method below
        @registration=@event.registrations.new(registration_params)
        @registration.user=current_user
        @registration.save

        if @registration.save
            flash[:notice] = "successfully saved...!"
            redirect_to event_registrations_path(@event)
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def registration_params
        params.require(:registration).permit(:how_heard)
    end
    def set_event
        @event=Event.find_by!(slug: params[:event_id])
    end
end
