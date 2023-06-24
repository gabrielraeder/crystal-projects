get "/" do |env|
  path = "/"
  travels = getAllExpanded(true)
  render "src/views/layouts/travels.ecr"
end

get "/optimized" do |env|
  path = "/optimized"
  travels = getAllOptmizedAndExpanded(true, true)
  render "src/views/layouts/travels.ecr"
end

get "/travel/edit/:id" do |env|
  id = env.params.url["id"]
  render "src/views/layouts/editTravel.ecr"
end

get "/travel/new" do |env|
  render "src/views/layouts/newTravel.ecr"
end

get "/travel/add/:id" do |env|
  id = env.params.url["id"]
  render "src/views/layouts/addStops.ecr"
end
