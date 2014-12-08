class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :table

  def initialize(message)
  	super()
  	self.message = message
  end

end
