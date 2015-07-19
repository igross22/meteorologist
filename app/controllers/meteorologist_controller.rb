require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    coordinate_address = "https://api.forecast.io/forecast/d780981f224f9a545797186f6e904bfb/" +@latitude + "," + @longitude
    raw_data = open(coordinate_address).read
    require 'json'
    parsed_data = JSON.parse(raw_data)

    @current_temperature = "do you work?"

    @current_summary = "@street_address"

    @summary_of_next_sixty_minutes = "Replace this string with your answer."

    @summary_of_next_several_hours = "Replace this string with your answer."

    @summary_of_next_several_days = "Replace this string with your answer."

    render("street_to_weather.html.erb")
  end
end
