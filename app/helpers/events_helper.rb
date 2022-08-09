module EventsHelper
    def price(event)
        if event.price==0
            "free"
        else
            number_to_currency(event.price,precision:0)
        end
    end
    def day_and_time(event)
        event.starts_at.strftime("%B %d at %I:%m %p")
    end
end
