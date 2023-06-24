def mergeSort(array : Array)
  return array if array.size <= 1

  mid = array.size // 2
  left = mergeSort(array[0, mid])
  right = mergeSort(array[mid, array.size])

  merge(left, right)
end

def merge(left : Array, right : Array)
  result = Array(Hash(String, Int64 | JSON::Any)).new
  i = 0
  j = 0

  while i < left.size && j < right.size
    if compare(left[i], right[j])
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  while i < left.size
    result << left[i]
    i += 1
  end

  while j < right.size
    result << right[j]
    j += 1
  end

  result
end

def compare(a : Hash(String, _), b : Hash(String, _)) : Bool
  if a["dimension"] != b["dimension"]
    return a["dimension"].to_json < b["dimension"].to_json
  elsif a["episodes"] != b["episodes"]
    return a["episodes"].to_json.to_i64 < b["episodes"].to_json.to_i64
  else
    return a["name"].to_json < b["name"].to_json
  end
end