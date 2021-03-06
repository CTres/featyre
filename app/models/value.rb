class Value < ActiveRecord::Base
  #Associations
  belongs_to :feature

  #Attributes
  attr_accessible :persona, :metric, :change, :quantity, :feature_id, :impact

  #Validations

  
	def impact
		#return nothing a field is blank
		unless self.persona.blank? or self.metric.blank?
			if self.quantity.blank?
				@impact = "#{self.persona} #{self.change} #{self.metric}"
			else
				@impact = "#{self.persona} #{self.change} #{self.metric} by #{self.quantity}"
			end
		else
		return nil
    end
	end

	# make sure that persona is capitalized
	def persona=(s)
		write_attribute(:persona, s.to_s.capitalize)
	end
end
