class Upload < ActiveRecord::Base
	belongs_to :idea
	has_attached_file :uploaded_file, 
	:styles => { :large => ['2000x2000>', :jpg, :quality => 50], 
							:thumb => ['200x200#',  :jpg, :quality => 70],
              :thumb_list => ['80x80#',  :jpg, :quality => 70] },
	:convert_options => {:thumb => "-strip" }, default_url: "/images/:style/missing.png"
end
