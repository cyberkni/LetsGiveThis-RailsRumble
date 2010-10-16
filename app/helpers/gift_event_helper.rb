module GiftEventHelper
  def generate_gift_title(gift_event)
    if gift_event.gift_link != ''
      if gift_event.gift_link =~ /^(http|https):\/\//
        "<h2><a href='#{gift_event.gift_link}'>#{gift_event.gift_name}</a></h2>"
      else
        "<h2><a href='http://#{gift_event.gift_link}'>#{gift_event.gift_name}</a></h2>"
      end
    else
      "<h2>#{gift_event.gift_name}</h2>"
    end
  end
end