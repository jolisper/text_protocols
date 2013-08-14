# TextProtocols

DSL to create basic text protocols

## Installation

Add this line to your application's Gemfile:

    gem 'text_protocols'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install text_protocols

## Usage

Create a file
    
    # my_server.rb
    require 'text_protocols'

    TextProtocols.start do
      cmd "say-hello" do
        "Hello #{params[:name]}"
      end
    end

Run the server
    
    $ ruby my_server.rb
    Text Protocols 0.0.1 - PID: 7331, Port: 5000

And telnet the port
   
    $ telnet localhost 5000
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    say-hello name=Jorge
    Hello Jorge

If you prefer different port or bind...
    
    TextProtocols.start '4000', '192.168.1.123' do
      # Your commands
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
