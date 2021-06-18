class AskController < ApplicationController
  def index
    
  end

  def new
    @doubt = Doubt.new
  end
  
  def redirectToDoubts 
    redirect_to '/doubts'
  end
  
  def create
    @doubt = Doubt.new(doubt_params)
    if @doubt.save
      redirectToDoubts()
    else
      render :new
    end
  end

  private
  def doubt_params
    defaults = { user_id: $loggedInUser['id'], isResolved: 0, is_picked:0, is_escalated:0}
    params.permit(:title, :description, :user_id, :isResolved).reverse_merge(defaults)
  end
end
