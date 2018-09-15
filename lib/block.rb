################################################################################
#   block.rb
#
#   Model: Block
#     Attributes:
#
#   15.09.2018  Created by: zhenya
################################################################################
require 'digest'
require 'json'

class Block
  attr_accessor :timestamp, :transactions, :previous_hash, :nonce, :hash
  
  def initialize args
    args.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
    @timestamp = Time.now
    @nonce = 0 if nonce.nil?
    @hash  = generate_hash
  end
  
  # Prints block contents
  def print_contents
    puts "\n===== Block content:"
    puts "timestamp:    #{timestamp_string}"
    puts "transactions: #{@transactions}"
#   puts "nonce:        #@nonce"
    puts "current hash: #{@hash}"
  end
  
  # Returns Timestamps as a String aka "2018-09-15 16:50:04.612431"
  def timestamp_string
    @timestamp.strftime('%Y-%m-%d %H:%M:%S.%6N')
  end
  
  # Generates hash of the blocks contents
  def generate_hash
    block_contents = timestamp_string + @transactions.to_json.gsub("\"", "'").gsub(",", ", ") + @previous_hash.to_s + @nonce.to_s
    Digest::SHA256.hexdigest block_contents
  end
end