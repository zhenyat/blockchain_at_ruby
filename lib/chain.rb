################################################################################
#   chain.rb
#
#   Model: Blockchain (class Chain)
#
#   15.09.2018  Created by: zhenya
################################################################################
require './block'

class Chain
  attr_accessor :blocks#, :unconfirmed_transactions
  
  def initialize
    @blocks                   = []
    #    @unconfirmed_transactions = []
    genesis_block
  end
  
  def add_block transactions
    previous_hash = @blocks.last.hash
    new_block     = Block.new transactions: transactions, previous_hash: previous_hash
    new_block.generate_hash
    proof = proof_of_work new_block
    @blocks << new_block
    proof
  end
  
  def genesis_block
    block = Block.new transactions: [], nonce: "0"
    block.generate_hash
    @blocks << block
  end
  
  def print_blocks
    @blocks.each do |block|
      block.print_contents
    end
  end
  
  def proof_of_work block, difficulty=2
    
    proof = block.generate_hash
    while proof[0...difficulty] != '0'*difficulty
      block.nonce += 1
      proof = block.generate_hash()
    end
    puts "+++++ nonce: #{block.nonce} | proof: #{proof}"
    block.nonce = 0
    
    proof
  end
  
  def validate_chain
    @blocks.each_with_index do |current, index|
      if index > 0
        previous = @blocks[index-1]
        if current.hash != current.generate_hash
          puts "The current hash of the block does not equal the generated hash of the block."
          return false
        end
        if current.previous_hash != previous.generate_hash
          puts "The previous block's hash does not equal the previous hash value stored in the current block."
          return false
        end
      end
    end
    puts "Chain validated successfully"
    true
  end
end
