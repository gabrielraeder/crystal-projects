def addStops(travel_id, stops)
  stops.each do |i|
    stop = Stop.new
    stop.stop_id = i.to_json.to_i64
    stop.travel_id = travel_id
    stop.save!
  end
end

def mapTravelStops(travel)
  array = Array(Int64 | Nil).new
  travel.stops.each do |i|
    array << i.stop_id
  end
  new_obj = {
    "id" => travel.id,
    "travel_stops" => array
  }
  return new_obj
end

def sumEpisodes(residents)
  counter = 0
  episodes = 0
  total = residents.size
  while counter < total
    link = residents[counter].to_json.gsub(/"(.*?)"/) { |match| match.delete("\"") }
    episodes += JSON.parse(HTTP::Client.get(link).body)["episode"].size
    counter += 1
  end
  return episodes.to_json.to_i64
end

def mapOneStop(i, isOptimized)
  req = HTTP::Client.get("https://rickandmortyapi.com/api/location/#{i}")
  hash = JSON.parse(req.body)
  new_hash = {
    "id" => hash["id"].to_json.to_i64,
    "name" => hash["name"],
    "type" => hash["type"],
    "dimension" => hash["dimension"],
  }
  if isOptimized === true
    new_hash["episodes"] = sumEpisodes(hash["residents"])
  end
  return new_hash
end

def mapExpandedStops(travel, isOptimized)
  stops = travel.stops.map { |i| mapOneStop(i.stop_id, isOptimized) }
  return {
    "id" => travel.id,
    "travel_stops" => stops
  }
end

def mapOptimizedStops(travel, isExpanded)
  expanded = mapExpandedStops(travel, true)
  sorted_array = mergeSort(expanded["travel_stops"].as(Array(Hash(String, Int64 | JSON::Any))))
  sorted_array = sorted_array.map do |i|
    if isExpanded == false
      i = i["id"]
    else
      i.as(Hash(String, Int64 | JSON::Any)).delete("episodes")
      i
    end
  end
  return {
    "id" => expanded["id"],
    "travel_stops" => sorted_array
  }
end