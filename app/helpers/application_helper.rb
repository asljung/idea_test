module ApplicationHelper
	# Returns the full title on a per-page basis.
  	def full_title(page_title)
	    base_title = "Idea App"
	    if page_title.empty?
	      base_title
	    else
	      "#{base_title} | #{page_title}"
	    end
  	end

  	def paginate(collection, params= {})
    	will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  	end
end
