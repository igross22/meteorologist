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

    coordinate_address = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&sensor=false"
    raw_data = open(coordinate_address).read
    require 'json'
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]
    first = results[1]


    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    # why do I need to turn variables above into .to_s? Without it I get a warning about "no implicit coversion intro string"


    temp_coordinate_address = "https://api.forecast.io/forecast/d780981f224f9a545797186f6e904bfb/" +@latitude + "," + @longitude
    temp_raw_data = open(temp_coordinate_address).read
    require 'json'
    temp_parsed_data = JSON.parse(temp_raw_data)

    @current_temperature = temp_parsed_data["currently"]["temperature"]

    @current_summary = temp_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = temp_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = temp_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = temp_parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
