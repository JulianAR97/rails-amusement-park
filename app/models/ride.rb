class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    errors = []
    errors << "You do not have enough tickets to ride the #{attraction.name}." unless valid_tickets?
    errors << "You are not tall enough to ride the #{attraction.name}." unless valid_height?
    errors.empty? ? start_ride : errors.unshift('Sorry.').join(' ')
  end

  def start_ride
    new_tickets = user.tickets -= attraction.tickets
    new_happiness = user.happiness += attraction.happiness_rating
    new_nausea = user.nausea += attraction.nausea_rating
    user.update({ tickets: new_tickets, happiness: new_happiness, nausea: new_nausea })
    "Thanks for riding the #{attraction.name}!"
  end

  def valid_tickets?
    user.tickets >= attraction.tickets
  end

  def valid_height?
    user.height >= attraction.min_height
  end
end
