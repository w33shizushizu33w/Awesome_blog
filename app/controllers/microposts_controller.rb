class MicropostsController < ApplicationController
     #「ApplicationController」というクラスを継承して、新たに「MicropostsController」というクラスを作っている
     before_action :only_loggedin_users, only: [:create, :destroy]

def create
     @micropost = current_user.microposts.build(micropost_params)
     if @micropost.save
          flash[:success] = "Successfully saved!"
          redirect_to root_url
     else
          @feed_items = []
          flash[:danger] = "Invalide content. Try again."
          redirect_to root_url
     end

end

def destroy
     Micropost.find(params[:id]).destroy
     redirect_to root_url
end

private
def micropost_params
     params.require(:micropost).permit(:content)
end

end

