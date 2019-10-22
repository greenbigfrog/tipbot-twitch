require "twitcr"

class TwitchBot
  def initialize(@coin : TB::Data::Coin)
    oauth_token = coin.twitch_oauth_token
    oauth_id = coin.twitch_oauth_id
    raise "Missing oauth token or ID" unless oauth_id && oauth_token
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
