get '/' do
  erb :index
end

post '/create_user' do
  user = User.new(email: params[:email], 
                  first_name: params[:first_name], 
                  last_name: params[:last_name] )
  user.password = params[:password]

  if user.save
    @user_success = true 
  else
    @user_success = false
  end

  erb :index
  # @validated_account = user.valid?

  # if user.valid?
  #   @bad_account = false

  # else
  #   @bad_account = true
  # end
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])

  if user
    session[:user] = user
    @user_login_success = true
  else
    session[:user] = nil
    @user_login_success = false
  end

  erb :index
end

get '/secretpage' do
  if session[:user]
    erb :secretpage
  else
    redirect to('/')
  end
end