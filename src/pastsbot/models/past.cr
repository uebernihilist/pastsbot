class Past < Moongoon::Collection
  collection "pasts"

  index keys: { name: 1, content: 1}, options: {unique: true}

  property name    : String
  property content : String
  property flag    : Bool
end
