require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================
    url = "https://maps.googleapis.com/maps/api/geocode/json?address="+@street_address_without_spaces

    require "open-uri"

    raw_data= open(url).read
    parsed_data=JSON.parse(raw_data)
    results=parsed_data["results"]
    first = results[0]
    geometry = first["geometry"]
    location= geometry["location"]

    @latitude_2=location["lat"].to_s
    @longitude_2=location["lng"].to_s

  
    url_weather="https://api.forecast.io/forecast/929b779df841220ca0160cb3dfa6a7d5/"+@latitude_2+","+@longitude_2

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

    render("meteorologist/street_to_weather.html.erb")
  end
end
