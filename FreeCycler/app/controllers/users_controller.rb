#encoding: utf-8
class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_salt, :password_hash)
  end

  def register
    @user = User.new
  end

  def registerpost

    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]

    if params[:password_confirmation] != params[:password]
      @user.errors.messages[:password] = ['Şifreleriniz uyuşmuyor.']
      render 'register'
      return
    end

    unless @user.valid?
      render 'register'
      return
    end

    @user.save

    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
    end

    redirect_to root_path
  end

  def editProfile
    @user = current_user
  end


  def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name)
    just_extension = File.extname(file_name)
    random = SecureRandom.hex(20)
    finalName = random + just_extension
  end

  def editProfilePost

    current_user.name = params[:name]

    if params[:profilePhotoUrl] != nil
      filename = sanitize_filename(params[:profilePhotoUrl].original_filename)
      directory = "public/images/profilePhotos"
      path = File.join(directory, filename)
      File.open(path, "wb") { |f| f.write(params[:profilePhotoUrl].read) }
      current_user.profilePhotoUrl =  filename
    end

    unless current_user.valid?
      render 'editProfile'
      return
    end

    current_user.save

    redirect_to editProfile_path, :notice => "Profiliniz güncellendi."
  end

  def myProfile

    @posts = Post.joins(:user).includes(:comments)
    .where("posts.isConfirmed='t' AND posts.user_id = ?", current_user.id)
    .order('posts.created_at DESC')

  end

end
