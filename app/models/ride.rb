require 'pry'
class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :attraction
  validates :user_id, :attraction_id, presence: true

  def take_ride
    #calls helper methods to check height and ticket requirements for the attraction
    ticket_message = enough_tickets
    height_message = tall_enough

    if ticket_message && height_message
      ticket_message + " " + height_message.split("Sorry. ").last
    elsif ticket_message
      ticket_message
    elsif height_message
      height_message
    else
      #update values
      update_user_attributes({
        tickets: self.attraction.tickets,
        happiness: self.attraction.happiness_rating,
        nausea: self.attraction.nausea_rating
        })
    end
  end
  def enough_tickets
    # binding.pry
    message = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    if self.user.tickets < self.attraction.tickets
      errors.add(:tickets, message)
      return message
    end
    nil
  end
  def tall_enough
    message = "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    if self.user.height < self.attraction.min_height
      errors.add(:height, message)
      return message
    end
    nil
  end
  def update_user_attributes(params)
    update_tickets(params[:tickets])
    update_nausea(params[:nausea])
    update_happiness(params[:happiness])
    self.user.save
  end
  def update_tickets(param)
    self.user.tickets -= param
  end
  def update_nausea(param)
    self.user.nausea += param
  end
  def update_happiness(param)
    self.user.happiness += param
  end
end
