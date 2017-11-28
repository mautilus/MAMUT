Sub init()
	m.cityName = m.top.FindNode("cityName")
	m.weatherPoster = m.top.FindNode("weatherPoster")
	m.cityWeather = m.top.FindNode("cityWeather")
	m.cityTemperature = m.top.FindNode("cityTemperature")
	m.cityMore = m.top.FindNode("cityMore")

	m.weatherTask = CreateObject("roSGNode", "WeatherQueryTask")
	m.weatherTask.ObserveField("result", "OnweatherTaskResult")
	m.weatherTask.control = "RUN"
End Sub

Sub OnweatherTaskResult()
	? "OnweatherTaskResult()" ; m.weatherTask.result
	if m.weatherTask.result.errors = invalid then
		? "DATA ::: " ; m.weatherTask.result.body
		m.cityName.text = m.weatherTask.result.body.name
		if m.weatherTask.result.body.weather.Count() > 0 then
			m.weatherPoster.uri = getIconUrl(m.weatherTask.result.body.weather[0].icon)
			m.cityWeather.text = m.weatherTask.result.body.weather[0].description
		end if
		if m.weatherTask.result.body.main <> invalid then
			m.cityTemperature.text = Substitute("Actual temperature: {0}°C   (Min.: {1}°C / Max.: {2}°C)",kelvinToDegrees(m.weatherTask.result.body.main.temp).ToStr(), kelvinToDegrees(m.weatherTask.result.body.main.temp_min).ToStr(), kelvinToDegrees(m.weatherTask.result.body.main.temp_max).ToStr())
			m.cityMore.text = Substitute("Pressure: {0} kPa   Humidity: {1} %", (m.weatherTask.result.body.main.pressure / 10).ToStr(), m.weatherTask.result.body.main.humidity.ToStr())
		end if
	else
		? "ERROR ::: " ; m.weatherTask.result.errors
	end if
End Sub
