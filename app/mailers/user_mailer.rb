class UserMailer < ActionMailer::Base
  default from: "no-reply@vateud.net"


  def task_email(task, emails)
    @task = task
    mail(:to => emails, :subject => "New tasked assigned to you by VATEUD")
  end

  def enabled_email(user)
    @user = user
    mail(:to => user.email, :subject => "VATEUD Tasks tracker account enabled")
  end
end

