class SessionController < Devise::SessionsController
    def create
      self.resource = warden.authenticate(auth_options)
      if self.resource
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        set_flash_message(:alert, "invalid")
        redirect_to("/")  
      end
    end
end