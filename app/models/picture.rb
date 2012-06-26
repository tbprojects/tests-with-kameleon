class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :project
  validates :picto, :presence => true
  has_attached_file :picto,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename",
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }


  def to_jq_upload
    {
        "name" => picto.original_filename,
        "size" => picto.size,
        "url" => picto.url,
        "thumbnail_url" => picto.url(:thumb),
        "delete_url" => picture_path(:id => id),
        "delete_type" => "DELETE"
    }
  end

end
