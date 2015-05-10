json.array!(@paragraphs) do |paragraph|
  json.extract! paragraph, :id, :author, :parag, :main, :main_id
  json.url paragraph_url(paragraph, format: :json)
end
