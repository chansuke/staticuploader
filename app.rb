require 'sinatra'

get '/index' do
  slim :index
end

post '/uploader' do
  if params[:file]
    save_path = "./public/images/#{params[:file][:filename]}"

    File.open(save_path, 'wb') do |f|
      p params[:file][:template]
      f.write params[:file][:template].read
      @mes = "success"
    end
  else
    @mes = "fail"
  end
  slim :uploader
  redirect 'images'
end

get '/images' do
  images = Dir.glob("public/images/*")
  @images_path = []

  images.each do |image|
    @images_path << image.gsub("public/", "./")
  end
  slim :images
end
