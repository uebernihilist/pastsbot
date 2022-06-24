require "./models/*"

class Storage
  def initialize
    Moongoon.connect("mongodb+srv://#{ENV["DB_USER_NAME"]}:#{ENV["DB_USER_PASSWD"]}@pastsbot.qmyxe.mongodb.net/?retryWrites=true&w=majority", ENV["DB_NAME"])
  end

  def get_past(name : String) : String
    Past.find_one!({ name: name }).content
  end

  def insert_past(name : String, content : String)
    Past.new(name: name, content: content, flag: true).insert
  end

  def get_all_pasts
    Past.find({ flag: true }).map(&.name)
  end

  def pasts_count
    Past.count.to_s
  end
end
