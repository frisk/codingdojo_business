json.array!(@bootcamps) do |bootcamp|
  json.extract! bootcamp, :title, :date
  json.url bootcamp_url(bootcamp, format: :json)
end