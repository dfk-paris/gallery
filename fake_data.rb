require 'faker'
require 'json'

require 'pry'

image_urls = [
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/069/image.jpg?1456305139",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/068/image.jpg?1452073708",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/067/image.jpg?1452073536",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/066/image.jpg?1452073534",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/065/image.jpg?1452073532",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/064/image.jpg?1452073405",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/063/image.jpg?1452071721",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/062/image.jpg?1448028395",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/061/image.jpg?1448028258",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/060/image.jpg?1447767395",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/059/image.jpg?1427118141",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/058/image.jpg?1427117749",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/057/image.jpg?1427117523",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/056/image.jpg?1427117327",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/055/image.jpg?1427117031",
  "https://testing-2-0.coneda.net/media/images/thumbnail/000/000/054/image.jpg?1456664164"
]

id = 0
data = image_urls.map do |url|
  item = {
    'id' => id += 1,
    'thumbnail' => url,
    'medium' => url.gsub('thumbnail', 'normal'),
    'title' => Faker::Book.title,
    'dating' => 1924 + (rand * 50).to_i,
    'fotographer' => Faker::Name.name,
    'copyright' => Faker::Company.name,
    'people_on_medium' => (rand * 5).to_i.times.map{ Faker::Name.name }
  }
end

File.open 'public/data.js', 'w' do |f|
  f.write JSON.dump(data)
end
