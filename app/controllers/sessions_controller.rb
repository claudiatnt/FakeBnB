class SessionsController < Clearance::SessionsController

	def new
		respond_to do |format|
			format.html { redirect_to sign_in_path}
			format.js
		end
	end

	def destroy
    sign_out
    redirect_to "/"
  end

end