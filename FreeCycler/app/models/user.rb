#encoding: utf-8
class User < ActiveRecord::Base
  validates_presence_of :name, :message => 'İsminizi girin.'
  validates_presence_of :password, :message => "Şifrenizi girin."
  validates_confirmation_of :password, :message => "Şifreleriniz uyuşmuyor."

  validates_presence_of :email, :message => "E-mailinizi girin."
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :message => "Geçersiz bir e-mail girdiniz."
 # validates_format_of :email, :with => /^(+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Geçersiz bir e-mail girdiniz."
  validates_uniqueness_of :email, :message => "Bu e-mail zaten kullanılıyor.", :on => :create
end
