class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: [:edit]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(message_params)
    if @prototype.save
      redirect_to("/")
    else
      render("prototypes/new")
    end
  end

  def show
    @prototype = Prototype.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find_by(id: params[:id])
  end

  def update 
    @prototype = Prototype.find_by(id: params[:id])
    @prototype.update(message_params)
    if @prototype.save
      redirect_to("/prototypes/#{@prototype.id}")
    else
      render("prototypes/edit")
    end
  end

  def destroy
    @prototype = Prototype.find_by(id: params[:id])
    @prototype.destroy
    redirect_to("/")
  end

  private
  def message_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype.user.id === current_user.id
      redirect_to action: :index
    end
  end
end
