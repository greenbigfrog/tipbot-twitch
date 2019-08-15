module ChatBot::Plugins::Support
  extend self

  def bind(bot, coin)
    bot.on(PRIVWHISP, message: /#{coin.prefix}support/, doc: {"support", "Responds with a link to a place to get support"}) do |msg|
      name = msg.display_name || ChatBot.extract_nick(msg.source)

      bot.reply(msg, ChatBot.mention(name, "For support please visit #{TB::SUPPORT}. (No registration required)"))
    end

    bot.on(message: /#{coin.prefix}help *$/, doc: {"help", "help [cmd]. Get help with a certain command by adding optional [cmd]"}) do |msg|
      bot.reply(msg, bot.docs.keys.join(", "))
    end

    bot.on(message: /^#{coin.prefix}help *(.*[^ ]) *$/) do |msg, match|
      doc = bot.docs[match.as(Regex::MatchData)[1]]?
      bot.reply(msg, "- #{doc}")
    end
  end
end
