json.array!(@blocks) do |block|
  json.extract! block, :id, :address, :limit, :count, :fromDay, :toDay, :fromHour, :toHour, :status
  json.url block_url(block, format: :json)
end