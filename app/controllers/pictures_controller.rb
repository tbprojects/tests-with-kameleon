class PicturesController < ApplicationController

  before_filter :authenticate_user!

  def create
    @picture = Picture.new(params[:picture])
    if @picture.save
      render :json => [@picture.to_jq_upload].to_json
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    render :json => true
  end

end
