class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends.all
  end

  def search_friend
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "User not found"
          format.js { render partial: 'friends/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or email to search"
        format.js { render partial: 'friends/result' }
      end
    end
  end
end
