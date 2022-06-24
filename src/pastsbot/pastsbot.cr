require "./paste"

module PastsBot
  class Bot
    getter client : Discord::Client
    getter prefix : Char | String
    getter paste : Paste

    def initialize
      @prefix = ENV["PREFIX"]
      @client = Discord::Client.new(token: ENV["TOKEN"], client_id: ENV["ID"].to_u64)
      @paste = Paste.new(Path["./pastes.json"])
    end

    def start
      message_create_handler
      @client.run
      Log.info { "Pastsbot started!" }
    rescue ex : JSON::SerializableError
      # ...
    end

    def message_create_handler
      @client.on_message_create do |payload|
        if payload.author.id == ENV["ID"].to_u64
          if payload.content.starts_with? @prefix
            msg = payload.content.strip(@prefix).split(3)
            cmd, name, content = msg[0], msg[1]?, msg[2]?

            command_handler cmd, name, content, {payload.channel_id, payload.id}
          else
            # Ignore
          end
        end
      end
    end

    def command_handler(cmd : String, name : String?, content : String?, payload : Tuple(Discord::Snowflake, Discord::Snowflake))
      @client.edit_message payload[0], payload[1],
      case cmd
      when "add"
        if !content.nil?
          @paste.add_one(name.not_nil!, content)
          "`paste added`"
        else
          "`no content given`"
        end
      when "get"
        paste = @paste.get_one?(name.not_nil!)
        paste.nil? ? "`not found`" : paste
      when "get-all"
        "```#{@paste.get_all.join(", ")}```"
      when "help"
        <<-STRING
        ```
        Let the prefix be ?

        ?add <name> <content> # add new paste to memory
        ?get <name> # get paste by name
        ?get-all    # get all pastes
        ?get-rand   # get random paste
        ?size       # amount of pastes
        ?save       # save pastes to disk from memory
        ?help       # show this message
        ```
        STRING
      when "size"
        @paste.size.to_s
      when "save"
        @paste.save
        "`saved!`"
      when "get-rand"
        @paste.get_random
      else
        "`wrong command`"
      end
    end
  end
end
