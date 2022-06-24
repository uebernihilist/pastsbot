require "./storage"

module PastsBot
  class Bot
    getter client : Discord::Client
    getter prefix : Char
    getter storage : Storage

    def initialize
      @prefix = ':'
      @client = Discord::Client.new(token: ENV["TOKEN"], client_id: ENV["ID"].to_u64)
      @storage = Storage.new
    end

    def start
      command
      @client.run
      Log.info { "Pastsbot started!" }
    end

    def command
      @client.on_message_create do |payload|
        if payload.author.id == ENV["ID"].to_u64
          if payload.content.starts_with? @prefix
            msg = payload.content.strip(@prefix)
            if msg.starts_with? '+'
              insert_paste msg.strip("+ ")
              @client.create_message(payload.channel_id, "`паста добавлена!`")
            elsif msg.starts_with? "?"
              @client.edit_message(payload.channel_id, payload.id, @storage.get_paste(msg.strip("? ")))
            elsif msg == "!"
              @client.edit_message(payload.channel_id, payload.id, "```\n#{@storage.get_all_pastes.join(", ")}\n```")
            elsif msg == "*"
              @client.edit_message(payload.channel_id, payload.id, @storage.pastes_count)
            elsif msg == "@"
              @client.edit_message(payload.channel_id, payload.id,
                "```sh\n:! # all pastes\n:* # the amount of all pastes\n" \
                ":+ name <> paste # add new paste\n:? paste # get paste by name```\n"
              )
            end
          else
            # Ignore
          end
        end
      end
    end

    private def insert_paste(msg : String)
      name, content = msg.split(" <> ")

      @storage.insert_paste name, content
    end
  end
end
