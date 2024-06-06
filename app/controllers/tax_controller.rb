class TaxController < ApplicationController

    def deduction
        employees = Employee.all
        tax_deductions = employees.map { |employee| calculate_tax(employee) }
        render json: tax_deductions
    end

    private

    def calculate_tax(employee)
        start_date = Date.new(Date.today.year - 1, 4, 1)
        end_date = Date.new(Date.today.year, 4, 1)
        start_date = employee.doj if employee.doj > start_date
        months_worked = ((end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)).to_f
        if employee.doj > start_date
            months_worked -= 1
        end
        total_salary = employee.salary * months_worked
        tax_amount = case total_salary
                     when 0..250000
                        0
                     when 250001..500000
                        (total_salary - 250000) * 0.05
                     when 500001..1000000
                        12500 + (total_salary - 500000) * 0.1
                     else
                        62500 + (total_salary - 1000000) * 0.2
                     end
        cess_amount = (total_salary > 2500000) ? (total_salary - 2500000) * 0.02 : 0
        {
            employee_code: employee.employee_code,
            first_name: employee.first_name,
            last_name: employee.last_name,
            yearly_salary: total_salary,
            tax_amount: tax_amount,
            cess_amount: cess_amount
        }
    end
end
