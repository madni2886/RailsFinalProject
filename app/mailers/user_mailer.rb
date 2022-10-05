class UserMailer < ApplicationMailer

  def oncreate
     @greeting = "Hi"
     @user=params[:user]
     @group=params[:group]
     x=@group.users

    mail(
      to: x[0].email,
      subject: "new Group created",
      message:@greeting

    )



  end
end
