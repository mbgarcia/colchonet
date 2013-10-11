class UserSessionsController < ApplicationController
	def destroy
		user_session.destroy
		redirect_to root_path, notice: t('flash.notice.signed_out')
	end
end