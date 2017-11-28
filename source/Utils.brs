function parameterListToString(urlParams as Object) as String
	paramList = []
	if urlParams <> invalid then
		for each parameter in urlParams.Items()
			if parameter.value <> invalid then
				paramList.Push(parameter.key.Escape()+"="+parameter.value.Escape())
			end if
		end for
	end if
	return paramList.Join("&")
end function

function getIconUrl(iconId as String) as String
	return "http://openweathermap.org/img/w/"+iconId+".png"
end function

function kelvinToDegrees(kelvinValue as Object) as Object
	if kelvinValue <> invalid then
		return (kelvinValue - 273.15)
	end if
	return 0
end function
