class UserMailer < ApplicationMailer
 
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sendemail.subject
  #
  def welcome_email(user)
  	puts "------------"
    mail to: user.email, subject: 'Rails Email Test'
  end
end
