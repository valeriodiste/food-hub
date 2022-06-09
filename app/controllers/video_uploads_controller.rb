class VideoUploadsController < ApplicationController
	def new
	  @video_upload = VideoUpload.new
	end

	def create
		@video_upload = VideoUpload.new(title: params[:video_upload][:title], description: params[:video_upload][:description], file: params[:video_upload][:file].try(:tempfile).try(:to_path))
	  
		if @video_upload.save
		  uploaded_video = @video_upload.upload!(current_user)
	  
		if uploaded_video.failed?
			flash[:error] = 'There was an error while uploading your video...'
		else

			recipe = Recipe.find_by(title: params[:video_upload][:recipetitle].to_s.split(/\s+/).map(&:downcase).map(&:capitalize).join(' '))
			recipe.video = "https://www.youtube.com/watch?v=#{uploaded_video.id}"
			recipe.save!

			flash[:success] = 'Your video has been uploaded!'

		  end
		  redirect_to profiles_path
		else
		  render :new
		end
	end
	  
	  
  end
  