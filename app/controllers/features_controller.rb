class FeaturesController < ApplicationController
  before_filter :find_user
  before_filter :authenticate_user!, :except => :index

  def index
    @features = Feature.all
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def new
    @feature = @user.features.new
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def create
    @feature = @user.features.new(params[:feature])
    if @feature.save
      redirect_to features_path, notice: "Feature was successfully created."
    else
      render "new"
    end
  end

  def update
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        redirect_to @features, notice: 'Feature was successfully updated.'
      else
        render action: "edit" 
      end
    end
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to users_url
  end

   def find_user
    if user_signed_in?
      @user = User.find(current_user.id)
      puts "wowowowowowowowowowowowowowowowooww"
      puts @user.id
    end
  end
end
