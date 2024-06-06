class TaxController < ApplicationController

    def deduction
        employees = Employee.all
        tax_deductions = employees.map { |employee| calculate_tax(employee) }
        render json: tax_deductions
    end

    private

    def calculate_tax(employee)
        start_date = Date.new(Date.today.year - 1, 4, 1)
        end_date = Date.new(Date.today.year, 3, 31)
        anual_salary = employee.salary * 12
        per_day = (employee.salary * 12)/365
        worked_on_days = (end_date - employee.doj).to_i
        actual_salary = per_day * worked_on_days
        tax_amount = case actual_salary
                     when 0..250000
                        0
                     when 250001..500000
                        actual_salary * 0.05
                     when 500001..1000000
                        actual_salary * 0.1
                     else
                        actual_salary * 0.2
                     end
        cess_amount = (actual_salary > 2500000) ? (actual_salary - 2500000) * 0.02 : 0
        {
            employee_code: employee.employee_code,
            first_name: employee.first_name,
            last_name: employee.last_name,
            yearly_salary: anual_salary,
            tax_amount: tax_amount,
            cess_amount: cess_amount
        }
    end
end
