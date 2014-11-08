class Loan < ActiveRecord::Base
  belongs_to :item
  has_one :borrower, :class_name => "User"
  has_one :lender, :class_name => "User"
end
