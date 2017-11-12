json.array! @steam_library.each do |game|
  json.appid game['appid']
  json.name game['name']
  json.playtime_forever game['playtime_forever']
  json.img_icon_url game['img_icon_url']
  json.img_logo_url game['img_logo_url']
end