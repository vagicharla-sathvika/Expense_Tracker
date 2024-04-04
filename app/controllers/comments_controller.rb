class CommentsController < ApplicationController
    def create
        @expense = Expense.find(params[:expense_id])
        @comment = @expense.comments.build(
          description: params[:description],
          expense_id: params[:expense_id]
          )
        authorize @comment
        if @comment.save
          render json: { comment: @comment.slice(:id, :description, :expense_id, :created_at, :updated_at), message: 'Comment added successfully.' }, status: :created

        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
    end
    def reply
      @comment = Comment.find(params[:id]) 
      @comment.reply = params[:reply]
      authorize @comment 
    
      if @comment.save
        render json: { reply: @comment.reply, message: 'Reply added successfully.' }, status: :created
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
end
