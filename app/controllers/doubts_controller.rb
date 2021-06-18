require 'json'

class DoubtsController < ApplicationController
  def getDoubts 
    @doubtStrings = Array.new()
    @doubts = Doubt.all
    @doubts.each do |i|
      @doubtString = (JSON.parse(i.to_json))
      @doubt_id = ((JSON.parse(i.to_json))['id']).to_i
      @doubtString['comments'] = Array.new()
      @commentsForDoubt = DoubtComment.where("doubt_id = ?", @doubt_id);
      @commentsForDoubt.each do |i|
        @commentForDoubt = JSON.parse(i.to_json)
        @comment_user_id =  @commentForDoubt['user_id'].to_i
        if @comment_user_id > 0
          @commentForDoubt['user_name'] = (JSON.parse(User.find(@comment_user_id).to_json))['name']
        end
        @doubtString['comments'].push(@commentForDoubt)
      end
      @user_id =  ((JSON.parse(i.to_json))['user_id']).to_i
       if @user_id > 0
        @doubtString['user_name'] = (JSON.parse(User.find(@user_id).to_json))['name']
       end
       @ta_user_id =  ((JSON.parse(i.to_json))['ta_user_id']).to_i
       if @ta_user_id > 0
        @doubtString['ta_user_name'] = (JSON.parse(User.find(@ta_user_id).to_json))['name']
       end
       @doubtStrings.push(@doubtString)
    end
    print @doubtStrings
  end

  def index
    getDoubts()
  end

  def create()
    $currentDoubtId= params[:doubt_id];
    @comment = DoubtComment.new(doubt_comment_params)
    if @comment.save
      getDoubts()
      redirect_to '/doubts'
    else
      render :new
    end
  end

  private
  def doubt_comment_params
    defaults = { user_id: $loggedInUser['id'], doubt_id: $currentDoubtId }
    params.permit(:body, :user_id, :doubt_id).reverse_merge(defaults)
  end
end
