Sub init()
	m.top.functionName = "getWeatherBycityId"
End Sub

Sub getWeatherBycityId()
	m.top.result = WeatherAPI().getCurrentWeather({id:m.top.cityId})
End Sub
