json.array!(@loans) do |loan|
  json.extract! loan, :id, :item_id, :borrower_id, :loaner_id, :approved, :reserved_start, :reserved_end
  json.url loan_url(loan, format: :json)
end
