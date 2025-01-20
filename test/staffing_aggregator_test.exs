defmodule StaffingAggregatorTest do
  use ExUnit.Case
  doctest StaffingAggregator

  test "successfully aggregates project data" do
    employees = [
      %{name: "Alice", project: "Project Alpha", hours_worked: 10, hourly_rate: 50.0},
      %{name: "Bob", project: "Project Beta", hours_worked: 20, hourly_rate: 40.0},
      %{name: "Charlie", project: "Project Alpha", hours_worked: 15, hourly_rate: 50.0},
      %{name: "Dana", project: "Project Gamma", hours_worked: 5, hourly_rate: 60.0}
    ]

    assert StaffingAggregator.aggregate_project_data(employees, "Project Alpha") == %{
             total_hours: 25,
             total_cost: 1250.0
           }
  end

  test "returns 0 for total hours and cost when no employees are provided" do
    assert StaffingAggregator.aggregate_project_data([], "Project Alpha") == %{
             total_hours: 0,
             total_cost: 0
           }
  end

  test "returns 0 for total hours and cost when the project is not found" do
    assert StaffingAggregator.aggregate_project_data(
             [%{name: "Alice", project: "Project Alpha", hours_worked: 10, hourly_rate: 50.0}],
             "Project Beta"
           ) == %{total_hours: 0, total_cost: 0}
  end

  test "raises an error when the employee data is not valid" do
    assert_raise KeyError, fn ->
      StaffingAggregator.aggregate_project_data(
        [%{name: "Alice", project: "Project Alpha"}],
        "Project Alpha"
      )
    end
  end
end
