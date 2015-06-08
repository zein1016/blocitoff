class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    flash[:notice] = "A message with a confirmation link has been sent to your email address.
      Please follow the link to activate your account."
      root_path
      
  end
end

