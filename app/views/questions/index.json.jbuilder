json.array!(@questions) do |question|
  json.extract! question, :content, :survey_id
  json.url question_url(question, format: :json)
end