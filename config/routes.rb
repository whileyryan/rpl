Rails.application.routes.draw do
  
  root 'team#index'

  post '/newSeason' => 'season#build'

  post '/playGame' => 'team#game'

  post '/decideGame' => 'team#results'

  get '/topScorersThisSeason' => 'team#topScorers'

  get '/playoffs' => 'team#playoffs'

  post '/decidePlayoff' => 'team#playoffResults'

  get '/winner' => 'team#winner'

  get '/allTime' =>'team#allTime'

  get '/champions' => 'team#champions'
  
end
