class Paste

  class File::NotFoundOrADError < File::Error end

  alias Pastes = Hash(String, String)

  property store : Pastes
  getter path : String | Path

  def initialize(path)
    if exists?(path)
      @store = (Pastes).from_json(File.read(path))
      @path = path
    else
      raise File::NotFoundOrADError.new("File is either not found or not writable", file: path)
    end
  end

  def initialize(@store, @path)
  end

  # Adds paste
  def add_one(name : String, content : String)
    @store[name] = content
  end

  # Adds paste and saves
  def add_one_and_save(name, content)
    add_one(name, content)
    save()
  end

  def get_all : Array(String)
    @store.keys
  end

  def get_one?(name : String) : String?
    @store[name]?
  end

  def get_random : String
    begin
      @store.sample[1]
    rescue ex : IndexError
      "nil"
    end
  end

  def save
    if exists?(@path)
      File.write(@path, @store.to_json)
    else
      raise File::NotFoundOrADError.new("File is either not found or not writable", file: @path)
    end
  end

  def size : Int32
    @store.size
  end

  private def exists?(path : String | Path)
    File.exists?(path) && File.readable?(path) && File.writable?(path)
  end
end
