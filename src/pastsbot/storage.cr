require "./models/*"

class Storage
  def initialize
    Moongoon.connect("mongodb+srv://#{ENV["DB_USER_NAME"]}:#{ENV["DB_USER_PASSWD"]}@#{ENV["DB_NAME"].downcase}.qmyxe.mongodb.net/?retryWrites=true&w=majority", ENV["DB_NAME"])
  end

  def get_paste(name : String) : String
    Paste.find_one!({ name: name }).content
  end

  def insert_paste(name : String, content : String)
    Paste.new(name: name, content: content, flag: true).insert
  end

  def get_all_pastes
    Paste.find({ flag: true }).map(&.name)
  end

  def pastes_count
    Paste.count.to_s
  end
end
