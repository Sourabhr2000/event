class EventsController < ApplicationController
    layout "application"
    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    before_action :set_event, only: [:show,:edit,:update,:destroy]
    def index
        # @event=Event.all
        # @events=Event.where("starts_at>?",Time.now).order("starts_at desc")

        
        
        case params[:filter]
        when "past"
            @events=Event.past
        when "free"
            @events=Event.free
        when "recent"
            @events=Event.recent
        when "upcoming"
            @events=Event.upcoming
        else
            @events=Event.all
            @a=1
        end
    
        
    end
    def show
        @event=Event.find_by!(slug: params[:id])
        @likers= @event.likers
        if current_user
            @like  = current_user.likes.find_by(event_id:@event.id)
        end
        @categories = @event.categories
        puts @categories
    end
    def edit
        @event=Event.find_by!(slug: params[:id])
    end
    def update
        @event=Event.find_by!(slug: params[:id])
        if @event.update(event_params)
            # flash[:alert] = "successfully saved...!"
            redirect_to @event, alert: "updated done..!"
        else 
            # @event=@event.errors.full_messages
            render :edit, status: :unprocessable_entity

            # render "show",status: :unprocessable_entity
            # @event=Event.all
            # render json: @event,status: :unprocessable_entity

            # render file: "#{Rails.root}/public/404.html", layout: false

            # render "events/show", status: :unprocessable_entity #for rendering another method

            # render :inline => "<%= 1+2 %>", :layout => "application"
            
        end
    end
    def new
        @event=Event.new
        # 2.times{@event.registrations.build}
    end
    def create
        
        # puts params
        @event=Event.new(event_params)
        @event.save
        if @event.save
            flash[:notice] = "successfully saved...!"
            redirect_to @event #or we can also write here like==>>, notice: "saved successfully data"
        else 
            # @event=@event.errors.full_messages
            render :new, status: :unprocessable_entity
        end
    end
    def destroy
        @event=Event.find_by!(slug: params[:id])
        @event.destroy
        redirect_to root_path, status: :see_other
    end
    private
    def event_params
        params.require(:event).permit(:name,:description,:location,:price,:starts_at,
        :capacity, :image_field, registrations_attributes: [:name,:email,:how_heard], category_ids:[])
    end

    def set_event
        @event=Event.find_by!(slug: params[:id])
    end 
end
