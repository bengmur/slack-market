module SlackMarket
  module Commands
    class Help < SlackRubyBot::Commands::Base
      HELP = <<~EOS.freeze
        ```
        I am your friendly market bot, providing quotes from IEX Trading.
        Try "What is the price of MSFT?" or "Tell me about AABA, AAPL and $I, please."

        General
        -------

        help                - get this helpful message
        info                - show bot credits
        subscription        - show subscription info

        Buy and Sell
        ------------

        bought [symbol]     - you bought a stock
        sold [symbol]       - you sold a stock
        positions           - display your current open positions
        positions [user]    - display someone else's current open positions

        Settings
        --------

        set dollars on|off  - respond to $QUOTE, but not QUOTE
        set charts on|off   - display charts below quotes
        set bots on|off     - allow interaction with bots (e.g. IFTTT)

        ```
      EOS
      def self.call(client, data, _match)
        client.say(channel: data.channel, text: [
          HELP,
          client.owner.reload.subscribed? ? nil : client.owner.subscribe_text
        ].compact.join("\n"))
        client.say(channel: data.channel)
        logger.info "HELP: #{client.owner}, user=#{data.user}"
      end
    end
  end
end
