 class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    session['token'] = env["omniauth.auth"]['credentials']['token']
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :github, :all
  alias_method :google_oauth2, :all
end
