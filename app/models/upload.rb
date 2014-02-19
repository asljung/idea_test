class Upload < ActiveRecord::Base
	belongs_to :idea
	has_attached_file :uploaded_file, styles: { original: "4000x4000>", large: "900x900>" , thumb: "200x200>" }, default_url: "/images/:style/missing.png"
end
