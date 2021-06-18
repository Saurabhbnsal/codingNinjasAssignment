require 'json'

class TaDoubtsController < ApplicationController
  def index
    @doubts = Doubt.where('isResolved' => 0).where('is_picked' => 0).where('is_escalated' => 0)
    end
    
    def accept
      @doubt = Doubt.find(params[:value])
      @doubt.update(is_picked: 1)
      @doubt.save
      redirect_to "/solve-doubt/" +  params[:value] 
    end
end
