''REQUIRED
''pkg:/_unit_tests/WeatherQueryTask_Test_Case.brs
''pkg:/components/tasks/WeatherQueryTask.brs
''pkg:/source/WeatherAPI.brs
''pkg:/source/Utils.brs
''pkg:/components/__TestSuite/Asserts.brs
''END REQUIRED
''
function Main(args as Dynamic) as Dynamic
	m.top = {
		cityId:"3078610",
		result: invalid
	}
	m.tests = {
		getWeatherBycityId_default_city_id: TryCatchSubTest("__TEST__getWeatherBycityId_default_city_id()"),
		getWeatherBycityId_empty_city_id: TryCatchSubTest("__TEST__getWeatherBycityId_empty_city_id()")
	}
	return m.tests
end function

function __TEST__getWeatherBycityId_default_city_id() as Object
	m.top.result = invalid
	getWeatherBycityId()
	return MTR__AssertInvalid(m.top.result.errors) and MTR__EqValues(m.top.result.body.name, "Brno")
end function

function __TEST__getWeatherBycityId_empty_city_id() as Object
	m.top.result = invalid
	m.top.cityId = ""
	getWeatherBycityId()
	return not MTR__AssertInvalid(m.top.result.errors)
end function
