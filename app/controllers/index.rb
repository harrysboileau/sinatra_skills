get '/' do
  # render home page
  @users = User.all

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

get '/edit' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    @skills = Skill.all
    @proficiencies = @user.proficiencies
    erb :edit
  else
    redirect '/'
  end
end

post '/edit' do
  puts params.inspect

  # skill = Skill.find_or_create_by(name: params[:skills])

  # "Piano, baseball, tennis, golf".split(",")

  # ["piano", "baseball"].each do |skill|
  #   Proficiency.create

  # end


  # user = User.find(session[:user_id])
  # skill = Skill.find_by(name: params[:skills])

  # prof = Proficiency.new(years: params[:years], formal: params[:formal])

  # prof.user = user
  # prof.skill = skill

  # user.proficiencies << prof

  # prof.save

  # user.skills << skill

  # user.skills << skill


  prof = Proficiency.create(user_id: session[:user_id],
                    skill_id: Skill.find_by(name: params[:skills]).id,
                    years: params[:years],
                    formal: params[:formal])
  # puts prof.inspect
  # user = User.find(session[:user_id])
  # user.name = params[:name]
  # puts user.inspect
  # user.save
  # puts User.find(session[:user_id]).inspect

  redirect '/'
end
 
post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end
