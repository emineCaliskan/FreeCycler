#encoding: utf-8
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, foreign_key: "post_id", dependent: :destroy

  validates_presence_of :bodyText, :message => 'Lütfen teklifinizi veya talebinizi açıklayın.'

end
