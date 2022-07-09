class Item < ApplicationRecord
from  = Time.current.at_beginning_of_day
to = (from + 6.day).at_end_of_day
items = Item.where(created_at: from...to)
end
