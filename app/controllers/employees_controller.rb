class EmployeesController < ApplicationController
    def index
        employees=Employee.all
        render json: employees, status: 200
    end
    def show
        employee=Employee.find_by(id:params[:id])
        if employee
          render json: employee, status: 200
        else
          render json: {
            error: "employee not found"
          }
        end
    end
    def new
    end
    
    def create
        employee=Employee.new(
          name: params[:name],
          department: params[:department],
          employment_status: params[:employment_status],
          email: params[:email],
          admin_status: params[:admin_status],
          user_id: params[:user_id]
        )
        if employee.save
          render json: employee, status: 200
        else
          render json: {
            error: "Error Creating.."
          }
        end
    end
    
    def edit
    end
    
    def update
        employee=Employee.find_by(id:params[:id])
        if employee
          employee.update(name: params[:name], department: params[:department], employment_status: params[:employment_status],admin_status: params[:admin_status],email: params[:email])
          render json: "Details of the employee are updated successfully", status: 200
        else
          render json: {
            error: "Employee details are not found"
          }
        end
    end
    
    def destroy
        employee=Employee.find_by(id: params[:id])
        if employee
          employee.destroy
          render json: "employee has been deleted"
        end
    end
  
end
