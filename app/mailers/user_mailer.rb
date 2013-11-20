class UserMailer < ActionMailer::Base
  default from: "no-reply@vateud.net"


  def task_email(task_id, emails)
    @task = Task.find(task_id)
    mail(:to => emails, :subject => "New tasked assigned to you by #{Settings.org}")
  end

  def enabled_email(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "#{Settings.org} Tasks tracker account enabled")
  end

  def author_status_email(task_id)
    @task = Task.find(task_id)
    mail(:to => @task.author.email, :subject => "#{Settings.org} Tasks: task status changed")
  end

  def comment_assignees_email(comment_id, emails)
    @comment = Comment.find(comment_id)
    @task = comment.task
    mail(:to => emails, :subject => "#{Settings.org} Tasks: new comment posted on your task")
  end

  def new_user_admins_email(user_id, emails)
    @user = User.find(user_id)
    mail(:to => emails, :subject => "#{Settings.org} Tasks: new user registration")
  end

  
end

