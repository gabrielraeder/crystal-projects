def getAllTravel()
  travels = Travel.all
  travels_map = Array(Hash(String, Array(Int64 | Nil)| Int64 | Nil)).new
  travels.each do |travel|
    new_obj = mapTravelStops(travel)
    travels_map << new_obj
  end
  return travels_map
end


def getAllOptimized(query)
  if query == true
    travels = Travel.all
    return mapped = travels.map { |travel| mapOptimizedStops(travel, false) }
  end
  return getAllTravel()
end


def getAllExpanded(query)
  if query == true
    travels = Travel.all
    return travels.map { |travel| mapExpandedStops(travel, false) }
  end
  return getAllTravel()
end


def getAllOptmizedAndExpanded(isExpanded, isOptimized)
  if isOptimized == true && isExpanded == true
    return Travel.all.map { |travel| mapOptimizedStops(travel, true) }
  elsif isOptimized == true && isExpanded == false
    return getAllOptimized(true)
  elsif isOptimized == false && isExpanded == true
    return getAllExpanded(true)
  end
  return getAllTravel()
end


def getById(id)
  travel = Travel.find_by!(id: id)
  return mapTravelStops(travel)
end


def getByIdOptimized(id, query)
  if query == true
    travel = Travel.find_by!(id: id)
    return mapOptimizedStops(travel, false)
  end
  return getById(id)
end


def getByIdExpanded(id, query)
  if query == true
    travel = Travel.find_by!(id: id)
    return mapExpandedStops(travel, false)
  end
  return getById(id)
end


def getByIdOptmizedAndExpanded(id, isExpanded, isOptimized)
  if isOptimized == true && isExpanded == true
    travel = Travel.find_by!(id: id)
    return mapOptimizedStops(travel, true)
  elsif isOptimized == true && isExpanded == false
    return getByIdOptimized(id, true)
  elsif isOptimized == false && isExpanded == true
    return getByIdExpanded(id, true)
  end
  return getById(id)
end


def createTravel(stops : Array)
  travel = Travel.new
  travel.save!
  addStops(travel.id, stops)
  return { id: travel.id, travel_stops: stops }
end


def update(id, stops)
  old_stops = Stop.where(travel_id: id)
  old_stops.each do |stop|
    stop.destroy!
  end
  addStops(id, stops)
  return getById(id)
end


def delete(id)
  travel = Travel.find_by!(id: id)
  travel.destroy!
end

def append(id, stops)
  addStops(id, stops)
  return getById(id)
end