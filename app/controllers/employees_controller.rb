class EmployeesController < ApplicationController
    def create
        begin
            binding.pry
            employee = Employee.new(employee_params)
            employee.employee_code = generate_employee_code
            employee.save!
            render json: employee, status: :created
        rescue ActiveRecord::RecordInvalid => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    private
    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :email, :doj, :salary, phone_number: [])
    end
        
    def generate_employee_code
        last_employee = Employee.order(:created_at).last
        last_number = last_employee ? last_employee.employee_code.gsub(/\D/, '').to_i : 0
        new_number = last_number + 1
        "EMP#{new_number.to_s.rjust(4, '0')}"
    end
end
