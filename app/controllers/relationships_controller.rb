class RelationshipsController < ApplicationController
  
  # フォローするとき
  def create
   current_user.follow(params[:id])
   redirect_back(fallback_location: root_path)
  end
  
  # フォロー外すとき
  def destroy
   current_user.unfollow(params[:id])
   redirect_back(fallback_location: root_path)
  end

end
