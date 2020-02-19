require "twitcr"

class TwitchBot
  def initialize(@coin : TB::Data::Coin, oauth_token : String, oauth_id : String)
    @twitch = Twitcr::Client.new(oauth_token, oauth_id)
  end

  def start
    raven_spawn do
      begin
        ChatBot.start(@twitch, @coin)
      rescue ex
        Raven.capture(ex)
        puts ex
        sleep 1
      end
    end
  end
end
