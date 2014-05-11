#encoding: utf-8
class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :name, :message => 'İsminizi girin.'
  validates_presence_of :password, :message => "Şifrenizi girin.", :on => :create
  validates_confirmation_of :password, :message => "Şifreleriniz uyuşmuyor."

  validates_presence_of :email, :message => "E-mailinizi girin."
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :message => "Geçersiz bir e-mail girdiniz."
  # validates_format_of :email, :with => /^(+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Geçersiz bir e-mail girdiniz."
  validates_uniqueness_of :email, :message => "Bu e-mail zaten kullanılıyor.", :on => :create

  has_many :posts, foreign_key: "user_id", dependent: :destroy


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
