class ImagesController < ApplicationController
	def index
		@images = Image.all
		respond_to do |format|
			format.html
		end
	end
	def create
		@image = Image.new(image_params)
		respond_to do |format|
			if(@image.save)
				CreateVersionWorker.perform_async(@image.id.to_s)
				# @image.file.recreate_versions!
				format.html{redirect_to images_path}
			else
				format.html{render action: "index"}
			end
		end
	end
	def show
		@image = Image.find params[:id]
		respond_to do |format|
			format.html{}
			format.json{render json: {image: @image.ui_json}}
		end
	end
	private
	# Permit image params to create and update
	def image_params
		params.require(:image).permit(:file)
    end
end
