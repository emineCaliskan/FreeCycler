#encoding: utf-8
class UserController < ApplicationController

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

  end

end
