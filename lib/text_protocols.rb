require 'text_protocols/version'
require 'gserver'
require 'pry'

module TextProtocols

  def self.start port='5000', bind='127.0.0.1', &block
    set_signals_hooks
    start_server port, bind, block
  end

  def self.set_signals_hooks
    ['SIGINT', 'SIGTERM'].each do |signal|
      Signal.trap signal do
        log "Bye!"
        exit
      end
    end
  end
  
  def self.start_server port, bind, block
    server = Server.config port, bind, &block
    server.start
    sleep
  rescue Interrupt
    log "Server was interrupted..."
  end

  def self.log string
    puts string
    $stdout.flush
  end

  class Server < GServer
    attr_reader :bind, :port, :protocol
    
    def self.config port, bind, &block
      server = self.new bind, port, block
    end
    
    def initialize bind, port, block
      @bind     = bind
      @port     = port
      @protocol = Protocol.new 
      @protocol.instance_eval &block
      super(port, bind)
      
      puts "Text Protocols #{TextProtocols::VERSION} - PID: #{Process.pid.to_s}, Port: #{port}" 
      $stdout.flush
    end

    def serve io
      loop do
        if (message = io.readline)
          command, params = parser.parse message
          io.puts @protocol.handle command, params
        else
          io.close
          break
        end
      end
    end
    
    def parser
      RequestParser
    end
  end

  class Protocol
    attr_reader :params
    
    def initialize
      @commands = {}
    end

    def cmd name, &block
      @commands[name.upcase] = block
    end
    
    def handle command, args
      block = @commands[command.chomp.upcase]
      return "UNKNOWN" unless block
      
      @params = args || {}
      
      block.call
    end
  end 

  module RequestParser
    def self.parse message
      parts = message.split
      params = parts[1..-1].each_with_object({}) do |elem, hash| 
        key, value = elem.split '='
        hash[key.to_sym] = value
      end
      [parts[0], params]
    end
  end
  
end
