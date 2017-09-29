class ListController < ApplicationController
  before_action :admin_user , only: [:index]
  before_action :play , only: [:index]
  def index
    @list = Array.new
    Video.all.each do |video|
      if video.created_at < Time.zone.now.beginning_of_day
        break
      end
      @list.push video
    end
    @next_video_index = (params[:index].to_i+1) % @list.length if @list.length != 0
  end
  private
  def play
    if !Video.any? || Video.first.created_at < Time.zone.now.beginning_of_day
      flash[:danger] = "Play list is empty!"
      redirect_to root_url
    end
  end
end
