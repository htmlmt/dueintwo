class Message < ActiveRecord::Base
  belongs_to :loaner, :class_name => "User"
  belongs_to :borrower, :class_name => "User"
  belongs_to :loan
end
