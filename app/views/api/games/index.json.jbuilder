json.array! @games.each do |game|
  json.partial! 'game.json.jbuilder', game: game
end