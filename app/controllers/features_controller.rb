class FeaturesController < ApplicationController
  #Filters
  before_filter :find_user
  before_filter :authenticate_user!, :except => [:index, :show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  #Methods 

  def new
    @feature = @user.owned_features.new
    @value = @feature.values.new
    @photo = @feature.photos.build
  end

  def index
    if params[:query]
    @filters = params[:query].split
    @features = Feature.tagged_with(@filters)
    else
    @features= Feature.all
    end

    if user_signed_in?
    @myfeatures = @user.owned_features + @user.collaborated_features
    end
  end

  def show
    @feature = Feature.find(params[:id])
    @collaborators = @feature.collaborators
    @value = Value.find_by_feature_id(params[:id])
    @photo = @feature.photos.last
  end

  def edit
    @feature = Feature.find(params[:id])
    @collaborators = @feature.collaborators
    @value = Value.find_by_feature_id(params[:id]) || @feature.values.create()
    if @feature.photos.first.nil? 
      @photo = @feature.photos.build
    else
      @photo = @feature.photos.last
    end

  end

  def create
    @feature = @user.owned_features.new(params[:feature])
    respond_to do |format|
      if @feature.save
        #add the original poster as a feature user. 
        @feature.feature_users.create!(user_id: @user.id)
        format.html { redirect_to edit_feature_path(@feature) }
        format.js {redirect_to edit_feature_path(@feature) }
      else
        render "new"
      end
    end
  end

  def update
    puts params[:photos]
    @feature = Feature.find(params[:id])
    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to :back }
        format.js {}
        
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
    end
  end

  def add_collaborator
    #variables
    
    @feature = Feature.find(params[:id])
    email = params[:feature][:temp_collaborator]
    name = params[:feature][:temp_name]
    puts name
    puts email
    #begin
    #find the collaborator and return the id so we can make the join model record (feels like an ugly hack :)
    id = @feature.find_or_create_collaborator(email, name, session['token'])
    puts id
    puts 'we made it through the invite process'
    @feature.feature_users.create!(user_id: id)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js {}
    end
  # rescue
  #   redirect_to :back, notice: 'no such user found at github'
  # end
  end

  def remove_collaborator
    @feature = Feature.find(params[:id])
    respond_to do |format|
      if @feature.delete_collaborator(params[:temp_collaborator])
        format.html { redirect_to :back }
        format.js {}
      end
    end
  end

  def add_image
    @feature = Feature.find(params[:id])
    @photo = @feature.photos.new(params[:photo])
    respond_to do |format|
      if @photo.save
        format.html {redirect_to :back}
      end
    end
  end

end
