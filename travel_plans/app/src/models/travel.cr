class Travel < Granite::Base
  connection mysql
  table travels

  has_many stops : Stop

  column id : Int64, primary: true
end