class EmployeeReader < ApplicationService
  include HTTParty
  BASE_URI = Settings.employee_api_base_uri 
  base_uri BASE_URI

  def call
    create_employees(format_data(fetch_data))
  end

  private

  def fetch_data 
    self.class.get("/employees", { headers: {"accept" => "application/json"} }).body
  end

  def format_data(json_data) 
    JSON.parse(json_data)["data"]
  end

  def create_employees(json_data)
    json_data.map do |employee_data|
      employee = Employee.new
      employee.from_json(employee_data.to_json)
    end
  end

end