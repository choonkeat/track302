Track302::Engine.routes.draw do
  get ":uuid(/*path)" => "redirect#show"
end
