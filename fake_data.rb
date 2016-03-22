require 'faker'
require 'json'

require 'pry'

image_urls = [
  {
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/047/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/047/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/046/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/046/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/085/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/085/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/052/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/052/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/043/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/043/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/064/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/064/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/063/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/063/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/062/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/062/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/061/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/061/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/060/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/060/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/059/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/059/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/058/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/058/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/057/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/057/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/056/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/056/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/055/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/055/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://testing-2-0.coneda.net/media/images/screen/000/000/054/image.jpg",
    'normal' => "https://testing-2-0.coneda.net/media/images/normal/000/000/054/image.jpg"
  },{
    'type' => 'image',
    'thumbnail' => "https://schepp-is.s3.amazonaws.com/kor-gallery/173.original.jpeg",
    'normal' => "https://schepp-is.s3.amazonaws.com/kor-gallery/173.original.jpeg"
  },{
    'type' => 'video',
    'thumbnail' => 'https://static.dfkg.org/public/loeb/video.png',
    'video/mp4' => "https://testing-2-0.coneda.net/media/images/mp4/000/000/081/document.mp4",
    'video/webm' => "https://testing-2-0.coneda.net/media/images/webm/000/000/081/document.webm",
    'video/ogg' => "https://testing-2-0.coneda.net/media/images/ogg/000/000/081/document.ogv"
  },{
    'type' => 'audio',
    'thumbnail' => 'https://static.dfkg.org/public/loeb/audio.png',
    'audio/mp3' => 'https://testing-2-0.coneda.net/media/images/mp3/000/000/087/document.mp3',
    'audio/ogg' => 'https://testing-2-0.coneda.net/media/images/ogg/000/000/087/document.ogg'
  }
]

id = 0
data = image_urls.map do |url|
  item = {
    'id' => id += 1,
    'title' => Faker::Book.title,
    'dating' => 1924 + (rand * 50).to_i,
    'fotographer' => Faker::Name.name,
    'copyright' => Faker::Company.name,
    'people_on_medium' => (rand * 5).to_i.times.map{ Faker::Name.name },
    'type' => url['type'],
    'urls' => url
  }
end

File.open 'public/data.js', 'w' do |f|
  f.write JSON.dump(data)
end
