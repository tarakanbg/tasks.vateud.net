class UserMailer < ActionMailer::Base
  default from: "no-reply@vateud.net"


  def task_email(task, emails)
    @task = task
    mail(:to => emails, :subject => "New tasked assigned to you by #{@org}")
  end

  def enabled_email(user)
    @user = user
    mail(:to => user.email, :subject => "#{@org} Tasks tracker account enabled")
  end

  def author_status_email(task)
    @task = task
    mail(:to => task.author.email, :subject => "#{@org} Tasks: task status changed")
  end

  def comment_assignees_email(comment, emails)
    @comment = comment
    @task = comment.task
    mail(:to => emails, :subject => "#{@org} Tasks: new comment posted on your task")
  end

  def new_user_admins_email(user, emails)
    @user = user
    mail(:to => emails, :subject => "#{@org} Tasks: new user registration")
  end

  
end

