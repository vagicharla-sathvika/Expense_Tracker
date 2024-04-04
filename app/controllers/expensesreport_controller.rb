class ExpensesreportController < ApplicationController
    def show
        @employee = Employee.find(params[:id])
        @expenses = @employee.expenses
        message = "This is the expense report of employee with ID: #{params[:id]}"
        render json: { message: message, expenses: @expenses }, status: :ok
    end
end
