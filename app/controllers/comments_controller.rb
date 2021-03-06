#:nodoc:
class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    comment_params = {
      user: current_user,
      commentable: find_parent_comment,
      body: params[:comment][:body]
    }
    @new_comment = Comment.new.comment_on! comment_params

    result = @new_comment.persisted? ? 'notice' : 'alert'

    flash[result.to_sym] = I18n.t("flash.comments.create.#{result}")

    redirect_to _commentable_path
  end

  def destroy
    @comment = @commentable.find_comment_by_id params[:id]

    @comment.destroy

    redirect_to _commentable_path, notice: t('flash.comments.destroy.notice')
  end

  private

  def find_commentable
    commentable_class = [Event, Talk].find { |x| x.name == params[:commentable_type].classify }

    @commentable = commentable_class.find(params[:commentable_id])
  end

  def find_parent_comment
    parent = @commentable.comments.find(params[:comment_id]) if params[:comment_id]

    parent || @commentable
  end

  def _commentable_path
    "/#{@commentable.class.name.pluralize.downcase}/#{@commentable._slugs[0]}"
  end
end
