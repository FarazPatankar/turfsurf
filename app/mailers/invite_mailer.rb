class InviteMailer < ApplicationMailer
  default from: "invites@turfsurf.co"

  def invite_email(invite)
  	@invite = invite
  	mail(to: @invite.email, subject: "Hello, #{@invite.name}")
  end

  def cancel_email(invite)
  	@invite = invite
  	mail(to: @invite.user.email, subject: "Hello, #{@invite.name}")
  end
end
