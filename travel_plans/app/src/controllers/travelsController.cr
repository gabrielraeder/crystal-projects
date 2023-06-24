def getAllController(env)
  expand = env.params.query["expand"] === "true"
  optimize = env.params.query["optimize"] === "true"
  return getAllOptmizedAndExpanded(expand, optimize).to_json
end


def getByIdController(env)
  id = env.params.url["id"]
  expand = env.params.query["expand"] === "true"
  optimize = env.params.query["optimize"] === "true"
  return getByIdOptmizedAndExpanded(id, expand, optimize).to_json
end


def createTravelController(env)
  json_data = env.params.json["travel_stops"].as(Array)
  env.response.status_code = 201
  return createTravel(json_data).to_json
end


def updateController(env)
  id = env.params.url["id"].to_i64
  json_data = env.params.json["travel_stops"].as(Array)
  return update(id, json_data).to_json
end


def deleteController(env)
  id = env.params.url["id"]
  env.response.status_code = 204
  return delete(id)
end


def appendController(env)
  id = env.params.url["id"].to_i64
  json_data = env.params.json["travel_stops"].as(Array)
  return append(id, json_data).to_json
end