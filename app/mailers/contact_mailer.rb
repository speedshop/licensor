class ContactMailer < ActionMailer::Base
  default from: "notifications@mg.speedshop.co"

  def contact_email
    mail(to: "nate.berkopec@speedshop.co", subject: "New RPW Inquiry") do |format|
      format.text { render plain: params[:data].inspect }
    end
  end
end
