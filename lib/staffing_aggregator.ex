defmodule StaffingAggregator do
  @moduledoc """
  Aggregate staffing data for a given project.

  ## Notes and clarifications

  - There are some [known issues](https://hexdocs.pm/elixir/1.12.3/Float.html#module-known-issues)
  in making operations directly with floats. To solve this, we can use a library like
  [Decimal](https://hexdocs.pm/decimal/readme.html) or other. For the sake of simplicity,
  we'll use floats.

  - If the employee data is not valid and the hours worked or hourly rate is not present, the
  function will raise an error when trying to make the operations.
  """

  @type employee :: %{
          name: String.t(),
          project: String.t(),
          hours_worked: float(),
          hourly_rate: float()
        }
  @type project_data :: %{total_hours: float(), total_cost: float()}

  @doc """
  Aggregate the total hours and total cost for a given project.

  ## Parameters

  - `employees`: A list of employee records.
  - `project_name`: The name of the project to aggregate data for.

  ## Returns

  A map with `total_hours` and `total_cost` fields.
  """
  @spec aggregate_project_data(list(employee), String.t()) :: project_data()
  def aggregate_project_data(employees, project_name) do
    employees
    |> Enum.filter(fn employee -> employee.project == project_name end)
    |> Enum.reduce(%{total_hours: 0, total_cost: 0}, fn employee, acc ->
      %{
        total_hours: acc.total_hours + employee.hours_worked,
        total_cost: acc.total_cost + employee.hours_worked * employee.hourly_rate
      }
    end)
  end
end
