defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

	def from(datetime={{year, month, day}, {hours, minutes, seconds}}) do
		:calendar.datetime_to_gregorian_seconds(datetime) + :math.pow(10, 9)
		|> round
		|> :calendar.gregorian_seconds_to_datetime
	end
end
