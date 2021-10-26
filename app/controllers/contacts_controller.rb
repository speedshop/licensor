class ContactsController < ApplicationController
  SUCCESS_URL = "https://speedshop.co/rpw_contact_success.html"

  def create
    ContactMailer.with(data: params.to_unsafe_h).contact_email.deliver_later
    redirect_to SUCCESS_URL
  end
end
