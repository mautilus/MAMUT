Function WeatherAPI(this = m) as Object
	this = GetGlobalAA()
	if this.api_object = invalid
			this.api_object = Api_NewInstance()
	end if
	return this.api_object
End Function

Function Api_NewInstance() as Object
	'NOTE: Api requests are limited to 60 per minute. If more requests are done
	'api is locked for 4 hours per additional request. Therefore you should insert
	'your own Api_Key from OpenWeatherMap.org'
	this = {
		Api_Key: "5d6a0559481cca70f7eee2d424f7582f",
		Api_Endpoint: "api.openweathermap.org",
		Timeout: 30 * 1000,	'ms'
		RetryCount: 3,
		getCurrentWeather: Api_getCurrentWeather
		'TODO: Add forecast for next 3/5 days
	}
	return this
End Function

Function Api_getCurrentWeather(urlParameters as Object) as Object

	if urlParameters = invalid then
		response = {
			errors: "Invalid parameters"
		}
		return response
	else 'Add api key'
		urlParameters.AddReplace("APPID", m.Api_Key)
	end if

	retry = 0
	timeout = m.Timeout

	GET_START: ' Restart from here on retry'
	if retry > 0 then
		? "Api_getCurrentWeather ::: retry : " ; retry
	end if

	urlTransfer = CreateObject("roUrlTransfer")
	port = CreateObject("roMessagePort")
	urlTransfer.setMessagePort(port)
	urlTransfer.EnableEncodings(true)
	urlTransfer.RetainBodyOnError(true)
	urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")

	urlTransfer.SetUrl(m.Api_Endpoint + "/data/2.5/weather?" + parameterListToString(urlParameters))

	response = invalid

	while retry < m.RetryCount
		if (urlTransfer.AsyncGetToString()) then
			msg = wait(timeout, port)
			if type(msg) = "roUrlEvent" and msg.GetResponseCode() > 0 then
				? "RAW RESPONSE: " ; msg.GetString()
				repsonseBody = ParseJson(msg.GetString())
				if repsonseBody <> invalid then
					response = {
						headers: msg.GetResponseHeadersArray(),
						body: repsonseBody
					}
				else
					response = {
						headers: msg.GetResponseHeadersArray(),
						body: msg.GetString()
					}
				end if
				' Add response code on error'
				code = msg.GetResponseCode()
				statusGroup = int(code/100)
				if statusGroup <> 2 and statusGroup <> 3 then
					response.AddReplace("errors", msg.GetResponseCode())
				end if
				exit while
			else 'if msg = invalid then
				urlTransfer.AsyncCancel()
			end if
		end if
		retry++
		timeout = m.Timeout * (retry+1)
		Goto GET_START
	end while

	return response
End Function
