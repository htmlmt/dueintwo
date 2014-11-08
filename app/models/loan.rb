class Loan < ActiveRecord::Base
  belongs_to :item
  belongs_to :loaner, :class_name => "User"
  belongs_to :borrower, :class_name => "User"
end
