json.array! @steam_library.each do |game|
  json.appid game['appid']
  json.name game['name']
  json.img_logo_url game['img_logo_url']
  json.playtime_forever game['playtime_forever']
end