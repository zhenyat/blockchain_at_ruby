# Benchmark for different Difficulties

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

#proof_of_work 1   # => nonce: 3:  0b4fd69a8d7a3f7e2694489dcb1afbfb2b94a7693b4b142d99d76dd821e543a0

proof_of_work 2   # => nonce: 3107:  000986c8511feaf74a9cb6aa96f491943386ebb0af145aa20eb81c86f1cd94e8

