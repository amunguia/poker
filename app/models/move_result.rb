require 'json'

class MoveResult

  attr_accessor :successful, :message

  def self.create_successful(message)
    result = build_result_base message
    result.successful = true
    result
  end

  def self.create_fail(message)
    result = build_result_base message
    result.successful = false
    result
  end

  def self.build_result_base(message)
    result = MoveResult.new
    result.message = message
    result
  end

  def to_json
    JSON.generate :successful => self.successful, :message => self.message 
  end

end

class CardResult

  def add_card(card)
    
  end

end