class User < ActiveRecord::Base
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minimun: 30, allow_blank: false
	validates_uniqueness_of :email

	has_secure_password

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end

	private

	def email_format
		errors.add(:email, :invalid) unless :email.match(EMAIL_REGEXP)
	end

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end
end
