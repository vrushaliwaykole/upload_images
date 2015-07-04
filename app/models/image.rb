class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  field :versions_created,type: Boolean,default: false
  mount_uploader :file, ImageUploader
  def ui_json
  	{versions_created: self.versions_created,original: {url: self.file.url},large: {url: self.file.large.url},medium: {url: self.file.medium.url},small: {url: self.file.small.url}}
  end
end
