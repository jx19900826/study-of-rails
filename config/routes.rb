Rails.application.routes.draw do
  resources :events do
    resources :attendees, :controller => 'event_attendees'
  end
end
