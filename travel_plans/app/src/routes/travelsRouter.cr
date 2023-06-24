before_all do |env|
  env.response.content_type = "application/json"
end

before_get ["/travel_plans", "/travel_plans/:id"] do |env|
  if !env.params.query.has_key?("expand")
    env.params.query["expand"] = "false"
  end
  if !env.params.query.has_key?("optimize")
    env.params.query["optimize"] = "false"
  end
end


get "/travel_plans" do |env|
  getAllController(env)
end


get "/travel_plans/:id" do |env|
  begin
    getByIdController(env)
  rescue ex : Exception
    halt env, status_code: 404, response: ex.message
  end
end


post "/travel_plans" do |env|
  begin
    createTravelController(env)
  rescue ex : Exception
    halt env, status_code: 400, response: ex.message
  end
end


put "/travel_plans/:id" do |env|
  begin
    updateController(env)
  rescue ex : Exception
    halt env, status_code: 400, response: ex.message
  end
end


delete "/travel_plans/:id" do |env|
  begin
    deleteController(env)
  rescue ex : Exception
    halt env, status_code: 404, response: ex.message
  end
end


patch "/travel_plans/:id/append" do |env|
  begin
    appendController(env)
  rescue ex : Exception
    halt env, status_code: 400, response: ex.message
  end
end
