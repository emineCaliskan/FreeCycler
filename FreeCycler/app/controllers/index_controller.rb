class IndexController < ApplicationController
  def index

    @posts = Post.joins(:user).includes(:comments)
    .where("posts.isConfirmed='t'")
    .order('posts.created_at DESC')

  end

  def createNewPost

    @post = Post.new
    @post.bodyText = params[:bodyText]
    @post.postType = params[:postType]
    @post.user_id = current_user.id
    @post.isConfirmed = true
    @post.isStillAvailable = true

    if @post.valid?
      @post.save
      redirect_to postSuccess_path
    end

  end

  def postSuccess

  end

  def saveComment

    comment = Comment.new
    comment.commentText = params[:commentText]
    comment.user_id = current_user.id
    comment.post_id = params[:postId]

    comment.save

    render json: comment
  end

end
