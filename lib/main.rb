#!/usr/bin/env ruby
################################################################################
#   Script to execute the App
#   
#   To run it in irb:   > loasd './main.rb'
################################################################################
require './chain'

block_one_transactions   = {sender: "Alice",  receiver: "Bob",   amount:"50"}
block_two_transactions   = {sender: "Bob",    receiver: "Cole",  amount:"25"}
block_three_transactions = {sender: "Alice",  receiver: "Cole",  amount:"35"}
fake_transactions        = {sender: "Bob",    receiver: "Cole, Alice", amount: "25"}

puts "===== Transactions"
puts block_one_transactions
puts block_two_transactions
puts block_three_transactions

puts "\n===== Chain"
local_chain = Chain.new
local_chain.add_block block_one_transactions
local_chain.add_block block_two_transactions
local_chain.add_block block_three_transactions

local_chain.print_blocks

puts "\n===== Validation"
local_chain.validate_chain

puts "\n===== Faked Transactions"
local_chain.blocks[2].transactions = fake_transactions

local_chain.validate_chain

