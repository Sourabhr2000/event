module RegistrationsHelper
    def register_or_sold_out(event)
        if event.sold_out?
            "sold out...!"
        else
            link_to "click here for registration", new_event_registration_path(@event),class:"button1"
        end
    end
end
