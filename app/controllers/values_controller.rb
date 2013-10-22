class ValuesController <ApplicationController
	def new
  end

  def create
		@feature = Feature.find(params[:feature_id])
		@value = @feature.values.new(params[:value_params])
    respond_to do |format|
      if @value.save
        #add the original poster as a feature user. 
        format.html { redirect_to edit_feature_path(@feature) }
        format.js {redirect_to edit_feature_path(@feature) }
      else
        redirect_to edit_feature_path(@feature)
      end
    end
  end

	def update
    puts params
    @feature = Feature.find(params[:id])
    puts @feature.title
		@value = @feature.values.find(params[:feature_id])
    respond_to do |format|
      if @value.update_attributes!(params[:value])
        format.html {  }
        format.js {}
      else
      puts 'damnit'
      end
    end
	end
end
