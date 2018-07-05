module ApplicationHelpers
  def is_user?
    begin
      user = Users.find_by(email = session[:user]['email'])
      return true if user
    rescue StandardError
      # ignored
    end
    false
  end

  def is_valid_email?(email)
    valid = '[A-Za-z\d.+-]+'
    (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
  end

  def validate_signup_params(params)
    errors = {
      'f_name' => [],
      'l_name' => [],
      'email' => [],
      'password' => [],
      'confirm_password' => []
    }
    values = {}
    options = {
      'f_name' => 'First name',
      'l_name' => 'Last name',
      'email' => 'Email',
      'password' => 'Password',
      'confirm_password' => 'Confirm password'
    }
    password = params[:password]
    confirm_password = params[:confirm_password]
    params.each do |k, v|
      values["#{k}_v"] = v
      if %w[password confirm_password].include?(k)
        errors[k] << "#{options[k]} must be more than 6 characters." if v.length < 6
        next
      end
      errors[k] << "#{options[k]} cannot be empty" if v.empty?

      next unless k == 'email'
      errors[k] << 'Invalid email address' unless is_valid_email?(v)
      if Users.find_by(email: v)
        errors[k] << 'Sorry, that email is already taken. Try another?'
      end
    end
    if password != confirm_password
      begin
        errors['confirm_password'] << 'Sorry, Password Mismatch'
      rescue NoMethodError
        errors['confirm_password'] = ['Sorry, Password Mismatch']
      end
    end
    params.delete('confirm_password')
    [[errors, values], params]
  end

  def display_signup_errors
    {
      'f_name' => [],
      'l_name' => [],
      'email' => [],
      'password' => [],
      'confirm_password' => []
    }
  end

  def display_signup_values
    {
      'f_name_v' => '',
      'l_name_v' => '',
      'email_v' => '',
      'password_v' => '',
      'confirm_password_v' => ''
    }
  end

  def display_login_values
    {
      'email_v' => '',
      'password_v' => '',
      'remember_v' => ''
    }
  end

  def display_login_errors
    {
      'email' => [],
      'password' => [],
      'msg' => ''
    }
  end

  def validate_login_params(params)
    errors = {
      'email' => [],
      'password' => [],
      'msg' => ''
    }
    values = {}
    options = {
      'email' => 'Email',
      'password' => 'Password'
    }
    params.each do |k, v|
      values["#{k}_v"] = v
      if k == 'email'
        errors[k] << 'Invalid email address' unless is_valid_email?(v)
      end
      next unless v.empty?
      errors[k] << "#{options[k]} cannot be empty"
      errors['msg'] = 'Invalid email address or password.'
    end
    [[errors, values], params]
  end

  def handle_sessions(user_params)
    @user = Users.find_by(email: user_params['email'])
    if @user
      if @user.confirm_password(user_params['password'])
        session[:user] = {
          f_name: @user.f_name,
          l_name: @user.l_name,
          email: @user.email
        }
        session.options[:expire_after] = 864000 unless params['remember'].nil?
        flash.next[:success] = {
          msg: "Welcome back #{session[:user][:f_name]} !"
        }
        true
      else
        false
      end
    end
  end

  def active_page?(page)
    'active' if page == @page
  end
end
