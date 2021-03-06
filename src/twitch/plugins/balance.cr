module ChatBot::Plugins::Balance
  extend self

  def bind(bot, coin)
    bot.on(PRIVWHISP, message: /^#{coin.prefix}(balance|bal)/, doc: {"balance", "Respond with the users balance"}) do |msg|
      name = msg.display_name || ChatBot.extract_nick(msg.source)
      raise NO_USER_ID unless id = msg.user_id
      # TODO get rid of static coin
      bal = TB::Data::Account.read(:twitch, id).balance(coin)

      TB::LOG.debug("#{name} (#{id}) has a balance of #{bal} #{coin.name_short}")
      str = "#{name}'s balance is: #{bal} #{coin.name_short}"
      str += " PopCorn Please pay attention to this important message: SSSsss #{coin.balance_broadcast} SSSsss" if coin.balance_broadcast
      bot.reply(msg, str)
    end
  end
end
