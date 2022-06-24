require "./shards"
require "./pastsbot/pastsbot"

Log.setup(:fatal)

Dotenv.load ".env"

module PastsBot
  Log = ::Log.for("PastsBot")
  VERSION = "0.0.1" # SemVer
end

PastsBot::Bot.new.start
