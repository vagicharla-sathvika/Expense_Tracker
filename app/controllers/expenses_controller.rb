class ExpensesController < ApplicationController
    def index
        @employees=Employee.find(params[:employee_id])
        @expenses=@employees.expenses
        render json: @expenses, status: 200
    end
    def show
        @employee=Employee.find(params[:employee_id])
        @expense=@employee.expenses.find(params[:id])
        if @expense
          render json: @expense, status: 200
        else  
          render json: {
            error: "Expenses are not found"
          }
        end
    end
    def new
    end
    def create
      @employee = Employee.find(params[:employee_id])
      @expense = @employee.expenses.new(
        date: params[:date],
        description: params[:description],
        amount: params[:amount],
        invoice_number: params[:invoice_number],
        employee_id: params[:employee_id]
        )
      authorize @expense
      if @employee.employment_status == "active"
        if @expense.valid?
          validation_result = InvoiceValidatorService.validate_invoice(@expense.invoice_number)
          puts "Validation Result: #{validation_result}"
          if validation_result[:status] == true
            @expense.save
            render json: { expense: @expense, message: 'Expense created. Invoice is valid.', validation_details: validation_result }, status: :created
          else
          render json: { message: 'Expense rejected. Invoice is invalid.', validation_details: validation_result }, status: :unprocessable_entity
          end
        else
          render json: { error: "Expense data is invalid.", validation_details: @expense.errors }, status: :unprocessable_entity
        end
      else
        render json: { error: "Employee is not active." }, status: :unprocessable_entity
      end
    end
    
    def edit
    end
    
    def update
        @employee = Employee.find(params[:employee_id])
        @expense = @employee.expenses.create(date: params[:date],
        description: params[:description],
        amount: params[:amount],
        invoice_number: params[:invoice_number],
        employee_id: params[:employee_id]
        )
        authorize @expense
        if @expense
          @expense.update(
            ate: params[:date],
            description: params[:description],
            amount: params[:amount],
            invoice_number: params[:invoice_number],
            employee_id: params[:employee_id]
          )
          render json: "Details of the expenses are updated successfully", status: 200
        else
          render json: {
            error: "Expenses details are not found"
          }
        end
    end
    
    def destroy
      @employee = Employee.find(params[:employee_id])
      @expense = @employee.expenses.find(params[:id])  
      authorize @expense
      if @expense.destroy
        render json: { message: 'Expense has been deleted' }, status: :ok
      else
        render json: { error: 'Failed to delete expense' }, status: :unprocessable_entity
      end
    end
    def approve
      @expense = Expense.find(params[:id])
      authorize @expense, :approve?
      ExpenseMailer.approval_notification(@expense).deliver_now
      render json: { message: 'Expense approved successfully.', expense: @expense }
    end
    def reject
      @expense = Expense.find(params[:id])
      authorize @expense, :reject?
      ExpenseMailer.rejection_notification(@expense).deliver_now
      render json: { message: 'Expense rejected successfully.', expense: @expense }
    end
end
