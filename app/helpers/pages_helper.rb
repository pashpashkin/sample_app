module PagesHelper
	def logo
	image_tag("/images/logo.png", :alt => "Sample App", :class => "round")
	end
end
