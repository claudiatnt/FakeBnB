module ApplicationHelper

	def listing_verified?
		if self.verification == "unverified"
			return false
		else
			return true
		end
	end

end
