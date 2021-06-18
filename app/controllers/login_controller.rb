require 'json'

class LoginController < ApplicationController
 
  def index
    $loggedInUser = ''
  end
 
  def post
    @user = params[:username]
    @loggedUser = JSON.parse(User.where("username = ?", params[:username]).to_json)

    if @loggedUser.length == 1
      print @loggedUser[0]["id"]
      if(@loggedUser[0]["password"] == params[:password])
        $loggedInUser = @loggedUser[0];
        if @loggedUser[0]['isStudent']
          redirect_to '/doubts'
        else
          redirect_to '/ta-doubts'
        end
        print '\n Logged In'
      else
        print '\n PassWord not Valid'
      end        
    else
      print '\n Could not find valid user'
    end
   end

  private
  def doubt_params
    params.permit(:title, :description)
  end
end
