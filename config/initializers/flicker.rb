require 'flickraw'

FlickRaw.api_key= ENV["Key"]
FlickRaw.shared_secret= ENV["Secret"]

# list = flickr.photos.search(:tags => "sangria", ) 
#     id     = list[0].id
#     secret = list[0].secret
#     info = flickr.photos.getInfo :photo_id => id, :secret => secret
#     @photo = FlickRaw.url_m(info)
    
# sizes = flickr.photos.getSizes :photo_id => id

# # original = sizes.find {|s| s.label == 'Original' }
# puts original.width       # => "800" -- may fail if they have no original marked image