Stringy::Application.routes.draw do

  root to: 'home#index'
  post '/', to: 'home#contact', as: :contact

end
