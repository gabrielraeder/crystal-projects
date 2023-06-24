class Stop < Granite::Base
  connection mysql
  table stops

  belongs_to travel : Travel

  column id : Int64?, primary: true
  column stop_id : Int64?
  column travel_id : Int64?
end