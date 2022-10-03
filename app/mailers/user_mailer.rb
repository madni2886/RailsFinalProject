class UserMailer < ApplicationMailer

  def oncreate
     @greeting = "Hi"
     @user=params[:user]
     @group=params[:group]
    mail(
      to: "f180216@nu.edu.pk",
      subject: "new Group created",
      message:@greeting

    )



  end
end
