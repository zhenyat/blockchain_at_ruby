################################################################################
#   Benchmark for different Difficulties
#   
#   To run it in irb:   > load './benchmark.rb'
###############################################################################
require 'benchmark'
require 'digest'

def my_hash nonce
  b=Time.new.strftime('%Y-%m-%d %H:%M:%S.%6N') + nonce.to_s
  Digest::SHA256.hexdigest b
end

def proof_of_work difficulty, nonce=0
  proof = my_hash nonce
  while proof[0...difficulty] != '0'*difficulty
    nonce +=1
    proof = my_hash nonce
  end
  puts "nonce: #{nonce}:  #{proof}"
  proof
end

puts Benchmark.measure { proof_of_work 2 }