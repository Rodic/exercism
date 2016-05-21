defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """

  import :calendar, only: [day_of_the_week: 1, valid_date: 1]

  @weekday_to_int %{
    monday:    1,
    tuesday:   2,
    wednesday: 3,
    thursday:  4,
    friday:    5,
    saturday:  6,
    sunday:    7
  }

  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    day = Enum.find(
      valid_day_range(schedule, year, month),
      fn d ->
        day_of_the_week({year, month, d}) == @weekday_to_int[weekday]
      end
    )
    {year, month, day}
  end

  defp valid_day_range(schedule, year, month) do
    case schedule do
      :teenth -> 13..19
      :first  -> 1..7
      :second -> 8..14
      :third  -> 15..21
      :fourth -> 22..28
      :last   -> 31..(28 - 6) |> Enum.filter(&valid_date({year, month, &1}))
    end
  end
end
