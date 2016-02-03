module PostHelper

  def authenticated?
    session[:user_id] != nil
  end

  # checks to see if content is belong's to current signed in user
  def users_content?(post)
    session[:user_id] == post.user_id
  end

end