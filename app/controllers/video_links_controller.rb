class VideoLinksController < ApplicationController

	def new
	  @video_link = VideoLink.new
	end

	def create

		@video_link = VideoLink.new(url: params[:video_link][:url])
	  
		if @video_link.save

			recipe = Recipe.find_by(title: params[:video_link][:recipetitle].to_s.split(/\s+/).map(&:downcase).map(&:capitalize).join(' '))
			recipe.video = @video_link.url
			recipe.save!

			flash[:success] = 'Your video has been linked!'

			redirect_to profiles_path

		else
			render :new
		end
	end
	  
	  
  end
  