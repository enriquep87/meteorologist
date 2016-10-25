require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

url_weather= "https://api.forecast.io/forecast/929b779df841220ca0160cb3dfa6a7d5/"+@lat+","+@lng

require "open-uri"

raw_data_weather=open(url_weather).read
parsed_data_weather=JSON.parse(raw_data_weather)
currently=parsed_data_weather["currently"]
temperature_now =currently["temperature"]
summary=currently["summary"]
hourly=parsed_data_weather["hourly"]
summary_next_several_hrs=hourly["summary"]
minutely=parsed_data_weather["minutely"]
summary_next_min=minutely["summary"]
daily=parsed_data_weather["daily"]
summary_next_days=daily["summary"]

    @current_temperature = temperature_now

    @current_summary = summary

    @summary_of_next_sixty_minutes = summary_next_min

    @summary_of_next_several_hours = summary_next_several_hrs

    @summary_of_next_several_days = summary_next_days

    render("forecast/coords_to_weather.html.erb")
  end
end
