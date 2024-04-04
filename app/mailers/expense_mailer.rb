class ExpenseMailer < ApplicationMailer
    def approval_notification(expense)
        @expense = expense
        @employee = expense.employee
        mail(to: @employee.email, subject: 'Expense Approval Notification')
    end
    def rejection_notification(expense)
        @expense = expense
        @employee = expense.employee
        mail(to: @employee.email, subject: 'Expense Rejection Notification')
      end
end