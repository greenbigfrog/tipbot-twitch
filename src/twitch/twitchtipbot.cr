require "big"
require "big/json"

require "raven"

class TwitchTipBot
  def self.run
    Raven.configure do |raven_config|
      raven_config.async = true
    end

    Raven.capture do
      oauth_token = ENV["TWITCH_CLIENT_SECRET"]?
      oauth_id = ENV["TWITCH_CLIENT_ID"]?

      TB::Data::Coin.read.each do |coin|
        raven_spawn(name: "#{coin.name_short} Bot") do
          chat_password = coin.twitch_chat_password
          raise "Missing a Twitch related config value" unless chat_password && oauth_token && oauth_id

          TwitchBot.new(coin, oauth_token.not_nil!, oauth_id.not_nil!).start
        end
      end
    end

    sleep
  end
end
