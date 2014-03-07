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

    def flash_class(level)
      case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
      end
    end
end
