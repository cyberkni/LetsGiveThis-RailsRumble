module GiftEventHelper
  def generate_gift_title(gift_event)
    if gift_event.gift_link != ''
      "<h2><a href='#{gift_event.gift_link}'>#{gift_event.gift_title}</a></h2>"
    else
      "<h2>#{gift_event.gift_title}</h2>"
    end
  end
end