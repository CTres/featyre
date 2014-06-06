class FeaturesController < ApplicationController
  #Filters
  before_filter :find_user
  before_filter :authenticate_user!, :except => [:index, :show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  #Methods

  def new
    @feature = @user.owned_features.new
    @value = @feature.values.new
    @photo = @feature.build_title_photo
  end

  def index
    
    
    
    if params[:query]
    @filters = params[:query].split
    @features = Feature.tagged_with(@filters)
    else
    @features= Feature.all
    end

    if user_signed_in?
    @feature = @user.owned_features.new
    @value = @feature.values.new
    @photo = @feature.build_title_photo
    @myfeatures = @user.collaborated_features
    end
  end

  def show
    @feature = Feature.find(params[:id])
    @collaborators = @feature.collaborators
    @value = Value.find_by_feature_id(params[:id])
    @photo = @feature.title_photo

  end

  def edit
    @feature = Feature.find(params[:id])
    @collaborators = @feature.collaborators
    @value = Value.find_by_feature_id(params[:id]) || @feature.values.create()
    @photo = @feature.title_photo || @feature.build_title_photo
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
    redirect_to :root
  end

  def find_user
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end

  def add_collaborator
    @feature = Feature.find(params[:id])
    email = params[:feature][:temp_collaborator]
    name = params[:feature][:temp_name]
    #begin
    #find the collaborator and return the id so we can make the join model record (feels like an ugly hack :)
    id = @feature.find_or_create_collaborator(email, name, session['token'])
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
  def my_features
    @user = current_user
    @myfeatures = @user.owned_features + @user.collaborated_features
    respond_to do |format|
      format.js {}
    end
  end

  def add_image
    @feature = Feature.find(params[:id])
    @photo = @feature.photos.create(image: params[:photo])
    respond_to do |format|
      if @photo.save
        format.js { render "add_image" }
        # , :locals => { :url => "#{@photo.image_url}" }
      end
    end
  end

end
