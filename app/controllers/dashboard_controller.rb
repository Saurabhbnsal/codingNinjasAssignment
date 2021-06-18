require 'json'
require 'time'
class DashboardController < ApplicationController
  def index
    @doubts = JSON.parse((Doubt.all).to_json)
    @total_doubts = @doubts.length
    @resolved_doubts = 0
    @escalated_doubts = 0
    @total_resolution_time = 0
    @doubts.each do |doubt|
      if doubt['isResolved']
        @resolved_doubts += 1
        @total_resolution_time += (Time.parse(doubt['updated_at']) - Time.parse(doubt['created_at']))
      elsif doubt['is_escalated']
        @escalated_doubts +=1 
      end 
    end
    @average_resolution_time = @total_resolution_time / @resolved_doubts
    @average_resolution_time_hours = Time.at(@average_resolution_time).utc.strftime "%H"
    @average_resolution_time_minutes = Time.at(@average_resolution_time).utc.strftime "%M"
    getUsers()
  end
    
  def getUsers
    @users = JSON.parse(User.where('isStudent' => false).to_json)
    @users.each do |user|
      @user_id = user['id']
      @resolvedDoubts = JSON.parse(DoubtDetail.where('ta_id' => @user_id).where('status = ? ', 'resolved').to_json) 
      user['averageResolutionTime'] = 0
      @resolvedDoubts.each do |doubt|
        @picked_doubt =  JSON.parse(DoubtDetail.where('doubt_id' => doubt['doubt_id']).where('ta_id' => doubt['ta_id']).where('status = ? ', 'picked').to_json)
        @picked_doubt.each_with_index do |picked, index|
          if index == 0
            @picked_time = picked['created_at']
            @resolved_time = doubt['created_at']
            user['averageResolutionTime'] += ( Time.parse(@resolved_time)- Time.parse(@picked_time) )
          end
        end
      end
      if @resolvedDoubts.length > 0
        user['averageResolutionTime'] = user['averageResolutionTime']/(@resolvedDoubts.length)
      else
        user['averageResolutionTime'] = 0
      end
      print user['averageResolutionTime']
      user['averageResolutionTimeHours'] = Time.at( user['averageResolutionTime']).utc.strftime "%H"
      user['averageResolutionTimeMinutes'] = Time.at(user['averageResolutionTime']).utc.strftime "%M"
      user['resolved'] = @resolvedDoubts.length
      user['escalated'] = JSON.parse(DoubtDetail.where('ta_id' => @user_id).where('status = ? ', 'escalated').to_json).length
      user['picked'] = JSON.parse(DoubtDetail.where('ta_id' => @user_id).where('status = ? ', 'picked').to_json).length
      print user
    end
  end
end
