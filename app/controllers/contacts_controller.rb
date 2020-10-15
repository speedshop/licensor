class ContactsController < ApplicationController
  def create
    ContactMailer.with(data: params.to_unsafe_h).contact_email.deliver_later
    redirect_to "https://speedshop.co/rpw_contact_success.html"
  end
end
