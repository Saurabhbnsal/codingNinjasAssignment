class SolveDoubtController < ApplicationController
  def index
    $doubt_id = params[:id]
    @doubt = Doubt.find($doubt_id)
    
    
    @doubtDetail = DoubtDetail.new(doubt_id:$doubt_id, status:'picked', ta_id:$loggedInUser['id'])
    @doubtDetail.save
    
    @doubtString = (JSON.parse(@doubt.to_json))   
    @doubtString['comments'] = Array.new()
    @commentsForDoubt = DoubtComment.where("doubt_id = ?", $doubt_id);
    @commentsForDoubt.each do |i|
      @commentForDoubt = JSON.parse(i.to_json)
      @comment_user_id =  @commentForDoubt['user_id'].to_i
      if @comment_user_id > 0
        @commentForDoubt['user_name'] = (JSON.parse(User.find(@comment_user_id).to_json))['name']
      end
      @doubtString['comments'].push(@commentForDoubt)
    end
    
    @user_id =  (@doubtString['user_id']).to_i
    if @user_id > 0
      @doubtString['user_name'] = (JSON.parse(User.find(@user_id).to_json))['name']
    end
end

  def update
    if params[:isEscalate] 
        escalate()
    else
      @doubtDetail = DoubtDetail.new(doubt_id:$doubt_id, status:'resolved', ta_id:$loggedInUser['id'])
      @doubtDetail.save
      
      @doubt = Doubt.find(params[:id])
      @doubt.update(answer: params[:answer], isResolved:true, ta_user_id:$loggedInUser['id'])
      if @doubt.save
        redirect_to '/ta-doubts'
      else
        render :new
      end
    end
  end

  def escalate
    @doubtDetail = DoubtDetail.new(doubt_id:$doubt_id, status:'escalated', ta_id:$loggedInUser['id'])
    @doubtDetail.save
    @doubt = Doubt.find(params[:id])
    @doubt.update(is_escalated:true, ta_user_id:$loggedInUser['id'])
    
    if @doubt.save
      redirect_to '/ta-doubts'
    else
      render :new
    end

  end
end
