class IdeasController < ApplicationController
  def index
    # @ideas = Idea.all.order("count(likes.id) desc")
    @ideas = Idea.all.sort {|x,y| y.likes.count <=> x.likes.count}
    # @ideas = Idea.joins(:likes).group("ideas.id").order("count(likes.id) desc")
  end

  def create
    idea = Idea.new idea_params
    unless idea.save
      flash[:errors] = idea.errors.full_messages
    end
    redirect_to "/ideas"
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy if @idea.user === current_user
    redirect_to "/ideas"
  end

  def show
    @idea = Idea.find(params[:id])
    @ideafans = Idea.find(params[:id]).users
  end

  private
    def idea_params
      params.require(:idea).permit(:post).merge(user: current_user)
    end
end
